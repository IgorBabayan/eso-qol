--[[
    Hold-to-open radial menu listing every unlocked collectible of one category type
    (companions, assistants). Built on the game's own ZO_InteractiveRadialMenuController,
    so it looks and behaves like the native quickslot / target marker wheels.

    Performance notes:
    * The top level control stays hidden while idle, so no OnUpdate handler runs outside of an interaction.
    * The list of unlocked collectibles, their names and icons are cached and rebuilt lazily,
      only after a collection event flagged the cache as dirty.
    * Per-open work is limited to cheap usability queries; entry data tables are pooled.
]]

local addon = EsoQol

local PLAYER = GAMEPLAY_ACTOR_CATEGORY_PLAYER
local MS_PER_SECOND = 1000

local CollectibleWheel = ZO_InteractiveRadialMenuController:Subclass()
addon.CollectibleWheel = CollectibleWheel

--[[
    config =
    {
        categoryType = COLLECTIBLE_CATEGORY_TYPE_*,
        emptyText = string,
        isCompanion = bool,
    }
]]
function CollectibleWheel:Initialize(control, config)
    ZO_InteractiveRadialMenuController.Initialize(self, control, "EsoQol_WheelEntry", "DefaultRadialMenuAnimation", "SelectableItemRadialMenuEntryAnimation")

    self.control = control
    self.config = config
    self.savedVars = nil

    self.collectibleIds = {}
    self.names = {}
    self.icons = {}
    self.isCacheDirty = true

    self.entryDataPool = {}
    self.numEntryDataUsed = 0

    -- One shared callback; the radial menu passes itself so the selected entry can be read back.
    self.onEntryChosen = function(menu)
        local selectedEntry = menu.selectedEntry
        if selectedEntry and selectedEntry.data then
            self:TryUseCollectible(selectedEntry.data.collectibleId)
        end
    end

    control:SetHidden(true)
end

function CollectibleWheel:SetSavedVars(savedVars)
    self.savedVars = savedVars
end

function CollectibleWheel:MarkCacheDirty()
    self.isCacheDirty = true
end

do
    local function SortByName(names)
        return function(left, right)
            return names[left] < names[right]
        end
    end

    function CollectibleWheel:RefreshCacheIfDirty()
        if not self.isCacheDirty then
            return
        end

        local ids, names, icons = self.collectibleIds, self.names, self.icons
        ZO_ClearNumericallyIndexedTable(ids)
        ZO_ClearTable(names)
        ZO_ClearTable(icons)

        local categoryType = self.config.categoryType
        for index = 1, GetTotalCollectiblesByCategoryType(categoryType) do
            local collectibleId = GetCollectibleIdFromType(categoryType, index)
            if IsCollectibleUnlocked(collectibleId) then
                ids[#ids + 1] = collectibleId
                names[collectibleId] = zo_strformat(SI_COLLECTIBLE_NAME_FORMATTER, GetCollectibleName(collectibleId))
                icons[collectibleId] = GetCollectibleIcon(collectibleId)
            end
        end

        if #ids > 1 then
            table.sort(ids, SortByName(names))
        end

        self.isCacheDirty = false
    end
end

-- Returns isUsable, blockedReasonText, isActive
function CollectibleWheel:GetCollectibleState(collectibleId)
    if IsCollectibleActive(collectibleId, PLAYER) then
        -- Selecting an active entry dismisses it, which is always allowed.
        return true, nil, true
    end

    if self.config.isCompanion then
        if HasPendingCompanion() then
            return false, GetString(SI_ESOQOL_REASON_COMPANION_PENDING), false
        end

        local questState = GetCollectibleAssociatedQuestState(collectibleId)
        if questState == COLLECTIBLE_ASSOCIATED_QUEST_STATE_INACTIVE or questState == COLLECTIBLE_ASSOCIATED_QUEST_STATE_ACCEPTED then
            return false, GetString(SI_ESOQOL_REASON_COMPANION_QUEST), false
        end
    end

    local cooldownRemainingMs = GetCollectibleCooldownAndDuration(collectibleId)
    if cooldownRemainingMs > 0 then
        local timeText = ZO_FormatTimeLargestTwo(zo_ceil(cooldownRemainingMs / MS_PER_SECOND), TIME_FORMAT_STYLE_DESCRIPTIVE_MINIMAL)
        return false, zo_strformat(SI_ESOQOL_REASON_COOLDOWN, timeText), false
    end

    if IsCollectibleBlocked(collectibleId, PLAYER) or not IsCollectibleUsable(collectibleId, PLAYER) then
        local reason = GetCollectibleBlockReason(collectibleId, PLAYER)
        local reasonText
        if reason ~= COLLECTIBLE_USAGE_BLOCK_REASON_NOT_BLOCKED then
            reasonText = GetString("SI_COLLECTIBLEUSAGEBLOCKREASON", reason)
        end
        if not reasonText or reasonText == "" then
            reasonText = GetString(SI_ESOQOL_REASON_UNAVAILABLE)
        end
        return false, reasonText, false
    end

    return true, nil, false
end

function CollectibleWheel:TryUseCollectible(collectibleId)
    if not collectibleId or collectibleId == 0 then
        return false
    end

    -- Re-validate: state can change while the wheel is open (combat, zoning, cooldowns).
    local isUsable, reasonText, isActive = self:GetCollectibleState(collectibleId)
    if not isUsable then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, SOUNDS.NEGATIVE_CLICK, reasonText)
        return false
    end

    UseCollectible(collectibleId, PLAYER)
    self.savedVars.lastCollectibleId = collectibleId

    if self.savedVars.chatMessage then
        -- Clickable [Name] link, built only when the message is actually sent.
        local link = GetCollectibleLink(collectibleId, LINK_STYLE_BRACKETS)
        addon:SystemMessage(zo_strformat(isActive and SI_ESOQOL_CHAT_DISMISS or SI_ESOQOL_CHAT_SUMMON, link))
    end
    return true
end

function CollectibleWheel:AcquireEntryData()
    local index = self.numEntryDataUsed + 1
    self.numEntryDataUsed = index
    local data = self.entryDataPool[index]
    if not data then
        data = {}
        self.entryDataPool[index] = data
    end
    return data
end

----------------------------------
-- ZO_InteractiveRadialMenuController overrides
----------------------------------

function CollectibleWheel:PrepareForInteraction()
    if not (self.savedVars and self.savedVars.enabled) then
        return false
    end

    if not SCENE_MANAGER:IsShowing("hud") then
        return false
    end

    self:RefreshCacheIfDirty()
    if #self.collectibleIds == 0 then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, SOUNDS.NEGATIVE_CLICK, self.config.emptyText)
        return false
    end

    return true
end

function CollectibleWheel:StartInteraction()
    local started = ZO_InteractiveRadialMenuController.StartInteraction(self)
    if started then
        -- Only visible (and therefore only ticking OnUpdate) while the key is held / the wheel is open.
        self.control:SetHidden(false)
    end
    return started
end

function CollectibleWheel:StopInteraction(clearSelection)
    local wasShowingRadial = ZO_InteractiveRadialMenuController.StopInteraction(self, clearSelection)
    -- While the close animation plays the menu is still shown; the menu's clear callback
    -- calls StopInteraction again once it has finished, and we hide then.
    if not self.menu:IsShown() then
        self.control:SetHidden(true)
    end
    return wasShowingRadial
end

function CollectibleWheel:PopulateMenu()
    self:RefreshCacheIfDirty()
    self.numEntryDataUsed = 0

    local hideUnavailable = self.savedVars.hideUnavailable
    local names, icons = self.names, self.icons
    local dismissText = GetString(SI_COLLECTIBLE_ACTION_DISMISS)

    for _, collectibleId in ipairs(self.collectibleIds) do
        local isUsable, reasonText, isActive = self:GetCollectibleState(collectibleId)
        if isUsable or not hideUnavailable then
            local data = self:AcquireEntryData()
            data.collectibleId = collectibleId
            data.isUsable = isUsable
            data.isActive = isActive

            local name = names[collectibleId]
            local label
            if not isUsable then
                label = { string.format("%s\n%s", name, reasonText), ZO_ERROR_COLOR }
            elseif isActive then
                label = { string.format("%s\n%s", name, dismissText), ZO_SELECTED_TEXT }
            else
                label = name
            end

            local icon = icons[collectibleId]
            self.menu:AddEntry(label, icon, icon, self.onEntryChosen, data)
        end
    end
end

function CollectibleWheel:SetupEntryControl(entryControl, data)
    ZO_SetupSelectableItemRadialMenuEntryTemplate(entryControl, data.isActive)
    -- Must run after the template setup, which resets desaturation.
    entryControl.icon:SetDesaturation(data.isUsable and 0 or 1)
    entryControl.icon:SetAlpha(data.isUsable and 1 or 0.45)
end

----------------------------------
-- Keybind entry points
----------------------------------

function CollectibleWheel:OnKeyDown()
    self:StartInteraction()
end

function CollectibleWheel:OnKeyUp()
    local wasShowingRadial = self:StopInteraction()
    if not wasShowingRadial then
        -- Short tap: the wheel never opened.
        local savedVars = self.savedVars
        if savedVars.enabled and savedVars.tapToggleLast then
            local lastId = savedVars.lastCollectibleId
            if lastId ~= 0 and IsCollectibleUnlocked(lastId) then
                self:TryUseCollectible(lastId)
            end
        end
    end
end

function CollectibleWheel:Cancel()
    if self:IsInteracting() or self.beginHold then
        local CLEAR_SELECTION = true
        self:StopInteraction(CLEAR_SELECTION)
    end
end
