--[[
    Undaunted pledges: when a pledge quest is in the journal, its dungeon is checked
    in the Dungeon Finder's specific dungeon list (keyboard and gamepad).

    How it fits the game's own code:
    * ZO_ACTIVITY_FINDER_ROOT_MANAGER clears every selection whenever the finder's filter changes or its
      data is rebuilt (quest added/removed, level up, group change...). Selections are therefore (re)applied
      right after those points through post-hooks, never by polling.
    * Selections are only applied while the specific-dungeon list is the active view, so a random-dungeon
      queue never gets specific dungeons mixed in.

    Performance notes:
    * The dungeon activity index is built once, on first use.
    * Journal scans run only on quest added/removed/player activated (25 entries max).
]]

local addon = EsoQol

local EVENT_NAMESPACE = addon.name .. "_Pledges"
local VETERAN_CHAMPION_POINTS = 160

local Pledges =
{
    savedVarsKey = "pledges",
    isEnabled = false,
    activityIndex = nil,      -- built lazily
    markedEntries = {},       -- [activityEntry] = questName
    appliedLocations = {},    -- [location] = true, locations this addon selected
}
addon.Pledges = Pledges

----------------------------------
-- Activity index
----------------------------------

local function NormalizeName(text)
    -- Strip grammar markers (^n etc.), lowercase (locale aware), drop whitespace and ASCII punctuation.
    local formatted = zo_strformat("<<1>>", text)
    return (zo_strlower(formatted):gsub("[%s%p]", ""))
end

local function SortByKeyLengthDesc(left, right)
    return #left.key > #right.key
end

function Pledges:GetActivityIndex()
    if self.activityIndex then
        return self.activityIndex
    end

    local byZoneId = {}
    local byName = {}
    local nameList = {}

    -- One entry per dungeon holding both difficulties; merged by zone id first, then by name.
    local dungeonTypes = { [LFG_ACTIVITY_DUNGEON] = "normal", [LFG_ACTIVITY_MASTER_DUNGEON] = "veteran" }
    for activityType, difficultyKey in pairs(dungeonTypes) do
        for index = 1, GetNumActivitiesByType(activityType) do
            local activityId = GetActivityIdByTypeAndIndex(activityType, index)
            local key = NormalizeName(GetActivityName(activityId))
            local zoneId = GetActivityZoneId(activityId) or 0

            local entry = (zoneId ~= 0 and byZoneId[zoneId]) or byName[key]
            if not entry then
                entry = {}
            end
            entry[difficultyKey] = activityId

            if zoneId ~= 0 then
                byZoneId[zoneId] = entry
            end
            if key ~= "" and not byName[key] then
                byName[key] = entry
                nameList[#nameList + 1] = { key = key, entry = entry }
            end
        end
    end

    -- Longest name first so "fungalgrottoii" wins over "fungalgrottoi".
    table.sort(nameList, SortByKeyLengthDesc)

    self.activityIndex = { byZoneId = byZoneId, nameList = nameList }
    return self.activityIndex
end

----------------------------------
-- Quest detection
----------------------------------

local function IsPledgeQuest(journalIndex)
    local questType = GetJournalQuestType(journalIndex)
    if QUEST_TYPE_UNDAUNTED_PLEDGE then
        return questType == QUEST_TYPE_UNDAUNTED_PLEDGE
    end
    return questType == QUEST_TYPE_DUNGEON and GetJournalQuestRepeatType(journalIndex) == QUEST_REPEAT_DAILY
end

function Pledges:ResolveActivityEntry(journalIndex)
    local index = self:GetActivityIndex()

    -- 1) Language independent: the quest's zone is the dungeon instance.
    local _, _, zoneIndex = GetJournalQuestLocationInfo(journalIndex)
    if zoneIndex and zoneIndex > 0 then
        local entry = index.byZoneId[GetZoneId(zoneIndex)]
        if entry then
            return entry
        end
    end

    -- 2) Fallback: "Pledge: <Dungeon Name>" contains the activity name.
    local questKey = NormalizeName(GetJournalQuestName(journalIndex))
    for _, nameData in ipairs(index.nameList) do
        if zo_plainstrfind(questKey, nameData.key) then
            return nameData.entry
        end
    end

    return nil
end

----------------------------------
-- Dungeon Finder selection
----------------------------------

local function GetLocation(activityId)
    if not activityId then
        return nil
    end
    local lookup = ZO_ACTIVITY_FINDER_ROOT_MANAGER.specificLocationsLookupData
    local byActivity = lookup and lookup[GetActivityType(activityId)]
    return byActivity and byActivity[activityId]
end

local function GetUnlockedLocation(activityId)
    local location = GetLocation(activityId)
    if location and not location:IsLocked() then
        return location
    end
    return nil
end

function Pledges:WantsVeteran()
    local difficulty = self.savedVars.difficulty
    if difficulty == "veteran" then
        return true
    elseif difficulty == "normal" then
        return false
    end
    return GetUnitChampionPoints("player") >= VETERAN_CHAMPION_POINTS
end

function Pledges:GetPreferredLocation(entry)
    if self:WantsVeteran() then
        return GetUnlockedLocation(entry.veteran) or GetUnlockedLocation(entry.normal)
    end
    return GetUnlockedLocation(entry.normal) or GetUnlockedLocation(entry.veteran)
end

-- Returns true when at least one selection changed.
function Pledges:ApplySelections()
    if not self.isEnabled or next(self.markedEntries) == nil or IsCurrentlySearchingForGroup() then
        return false
    end

    local manager = ZO_ACTIVITY_FINDER_ROOT_MANAGER
    local changed = false
    for entry in pairs(self.markedEntries) do
        local location = self:GetPreferredLocation(entry)
        if location and not location:IsSelected() then
            manager:SetLocationSelected(location, true)
            if location:IsSelected() then
                self.appliedLocations[location] = true
                changed = true
            end
        end
    end
    return changed
end

function Pledges:ClearAppliedSelections(onlyUnmarked)
    if IsCurrentlySearchingForGroup() then
        return false
    end

    local keep
    if onlyUnmarked then
        keep = {}
        for entry in pairs(self.markedEntries) do
            local normal, veteran = GetLocation(entry.normal), GetLocation(entry.veteran)
            if normal then keep[normal] = true end
            if veteran then keep[veteran] = true end
        end
    end

    local manager = ZO_ACTIVITY_FINDER_ROOT_MANAGER
    local changed = false
    for location in pairs(self.appliedLocations) do
        if not (keep and keep[location]) then
            self.appliedLocations[location] = nil
            if location:IsSelected() then
                manager:SetLocationSelected(location, false)
                changed = true
            end
        end
    end
    return changed
end

local function IsKeyboardSpecificFilterActive(finder)
    local selected = finder.filterComboBox and finder.filterComboBox:GetSelectedItemData()
    return selected ~= nil and selected.data ~= nil and not selected.data.singular
end

function Pledges:RefreshKeyboardView()
    local finder = DUNGEON_FINDER_KEYBOARD
    if finder and finder.fragment and finder.fragment:IsShowing() then
        finder:RefreshView()
    end
end

----------------------------------
-- Journal scan
----------------------------------

function Pledges:RescanJournal()
    local marked = self.markedEntries
    ZO_ClearTable(marked)

    if not self.isEnabled then
        return
    end

    for journalIndex = 1, MAX_JOURNAL_QUESTS do
        if IsValidQuestIndex(journalIndex) and IsPledgeQuest(journalIndex) then
            local entry = self:ResolveActivityEntry(journalIndex)
            if entry then
                marked[entry] = GetJournalQuestName(journalIndex)
            end
        end
    end

    if self:ClearAppliedSelections(true) then
        self:RefreshKeyboardView()
    end
end

----------------------------------
-- Events / hooks
----------------------------------

function Pledges:OnQuestAdded(journalIndex, questName)
    if not IsPledgeQuest(journalIndex) then
        return
    end

    local entry = self:ResolveActivityEntry(journalIndex)
    if entry then
        self.markedEntries[entry] = questName
    end

    if self.savedVars.notify then
        local formattedName = zo_strformat(SI_QUEST_JOURNAL_QUEST_NAME_FORMAT, questName)
        if entry then
            addon:SystemMessage(zo_strformat(SI_ESOQOL_PLEDGE_MARKED, formattedName))
        else
            addon:SystemMessage(zo_strformat(SI_ESOQOL_PLEDGE_NOT_FOUND, formattedName))
        end
    end
    -- No selection here: the manager marks itself dirty on EVENT_QUEST_ADDED and clears selections
    -- on its next update; the finder's filter refresh that follows triggers ApplySelections via the hooks.
end

function Pledges:InstallHooks()
    if self.hooksInstalled then
        return
    end
    self.hooksInstalled = true

    local keyboardFinder = DUNGEON_FINDER_KEYBOARD
    if keyboardFinder then
        -- Filter change (incl. reselection after a data rebuild) clears selections first; re-apply after.
        SecurePostHook(keyboardFinder, "OnFilterChanged", function(finder, _, _, filterEntry)
            if filterEntry and filterEntry.data and not filterEntry.data.singular then
                if self:ApplySelections() then
                    finder:RefreshView()
                end
            end
        end)

        -- On open: optionally jump to the specific list, and make sure marks are applied.
        local fragment = keyboardFinder:GetFragment()
        if fragment then
            fragment:RegisterCallback("StateChange", function(_, newState)
                if newState ~= SCENE_FRAGMENT_SHOWN or not self.isEnabled or next(self.markedEntries) == nil then
                    return
                end

                if IsKeyboardSpecificFilterActive(keyboardFinder) then
                    if self:ApplySelections() then
                        keyboardFinder:RefreshView()
                    end
                elseif self.savedVars.openSpecificList and not IsCurrentlySearchingForGroup() then
                    local comboBox = keyboardFinder.filterComboBox
                    for _, item in ipairs(comboBox:GetItems()) do
                        if item.data and not item.data.singular then
                            comboBox:SelectItem(item) -- fires OnFilterChanged -> ApplySelections
                            break
                        end
                    end
                end
            end)
        end
    end

    local gamepadFinder = DUNGEON_FINDER_GAMEPAD
    if gamepadFinder then
        -- Selection changes fire OnSelectionsChanged, which refreshes the gamepad list on its own.
        SecurePostHook(gamepadFinder, "RefreshHeaderAndView", function(finder, headerData)
            if headerData ~= nil and headerData == finder.specificHeaderData then
                self:ApplySelections()
            end
        end)
    end
end

function Pledges:SetEnabled(enabled)
    if self.isEnabled == enabled then
        return
    end
    self.isEnabled = enabled

    if enabled then
        self:InstallHooks()
        EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_QUEST_ADDED, function(_, journalIndex, questName)
            self:OnQuestAdded(journalIndex, questName)
        end)
        EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_QUEST_REMOVED, function()
            self:RescanJournal()
        end)
        EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_PLAYER_ACTIVATED, function()
            -- Journal indices can shift across zones/logins.
            self:RescanJournal()
        end)
        self:RescanJournal()
    else
        EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE, EVENT_QUEST_ADDED)
        EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE, EVENT_QUEST_REMOVED)
        EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE, EVENT_PLAYER_ACTIVATED)
        ZO_ClearTable(self.markedEntries)
        if self:ClearAppliedSelections(false) then
            self:RefreshKeyboardView()
        end
    end
end

function Pledges:Initialize(savedVars)
    self.savedVars = savedVars
    self:SetEnabled(savedVars.enabled)
end

addon:RegisterModule(Pledges)
