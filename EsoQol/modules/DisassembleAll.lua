--[[
    Disassemble All: adds a "Disassemble All" button next to "Deconstruct" on Giladil the Ragpicker's
    universal deconstruction screen (keyboard UI).

    Clicking it deconstructs, in batches of up to 100 items, everything the deconstruction list would show
    for the current tab, crafting type filter and "Include banked items" checkbox (filters other add-ons
    install on that list are honoured too), and keeps going until nothing is left. Skipped:
    * items with the Ornate trait,
    * locked items and items used in an Armory build.
    While it runs the button turns into "Stop". Closing the screen also stops it.

    How it fits the game's own code:
    * The button is appended to UNIVERSAL_DECONSTRUCTION's own keybind group, so the game shows, hides and
      refreshes it together with "Deconstruct" (incl. on crafting animation start/stop).
    * Batches use the same PrepareDeconstructMessage / AddItemToDeconstructMessage / SendDeconstructMessage
      calls as the game's own multi-deconstruct.

    Performance notes:
    * Nothing runs while idle: events and the update poll are registered only while a run is active.
    * Candidates come from SHARED_INVENTORY's bag caches (filled slots only, no table copies); a batch scan
      stops as soon as it has 100 items, and the cheapest checks run first.
]]

local addon = EsoQol

local EVENT_NAMESPACE = addon.name .. "_DisassembleAll"
local POLL_NAMESPACE = EVENT_NAMESPACE .. "_Next"
local CONFIRM_DIALOG = "ESOQOL_CONFIRM_DISASSEMBLE_ALL"
local KEYBIND = "UI_SHORTCUT_QUINARY" -- free on this screen (Secondary/Tertiary/Quaternary are used by item mouse-over actions)
local BATCH_LIMIT = 100
local POLL_INTERVAL_MS = 100
local MAX_ANIMATION_WAIT_MS = 5000 -- never wait on the result animation longer than this
local NO_LIMIT = math.huge

local DisassembleAll =
{
    savedVarsKey = "disassembleAll",
    isRunning = false,
    pendingCount = 0,      -- items in the batch sent to the server
    totalCount = 0,        -- items deconstructed in this run
    processed = {},        -- [uniqueIdString] = true, items already sent in this run
    waitStartMs = 0,
}
addon.DisassembleAll = DisassembleAll

----------------------------------
-- Candidate selection
----------------------------------

local function GetPanel()
    return UNIVERSAL_DECONSTRUCTION and UNIVERSAL_DECONSTRUCTION.deconstructionPanel
end

local BANK_BAGS = { BAG_BACKPACK, BAG_BANK, BAG_SUBSCRIBER_BANK }
local BACKPACK_ONLY = { BAG_BACKPACK }

-- Calls onItem(bagId, slotIndex, stackCount) for each item that qualifies, until it returns false or
-- `limit` items were visited. Mirrors ZO_UniversalDeconstructionInventory_Keyboard:Refresh.
function DisassembleAll:ForEachCandidate(limit, onItem)
    local panel = GetPanel()
    if not panel then
        return 0
    end

    local inventory = panel.inventory
    local craftingTypes = panel:GetSavedCraftingTypeFilters()
    local filterType = inventory:GetCurrentFilterType()
    local additionalFilter = type(inventory.additionalFilter) == "function" and inventory.additionalFilter or nil
    local bags = panel:GetSavedIncludeBankedItemsFilter() and BANK_BAGS or BACKPACK_ONLY
    -- Only look up unique ids (string allocation) once something was sent in this run.
    local processed = next(self.processed) ~= nil and self.processed or nil

    local IsDeconstructableBagItem = ZO_UniversalDeconstructionPanel_Shared.IsDeconstructableBagItem
    local DoesItemPassFilter = ZO_UniversalDeconstructionPanel_Shared.DoesItemPassFilter

    local count = 0
    for _, bagId in ipairs(bags) do
        local bagCache = SHARED_INVENTORY:GetOrCreateBagCache(bagId)
        for slotIndex, slotData in pairs(bagCache) do
            local stackCount = slotData.stackCount or 0
            -- Cheapest checks first; most backpack items (materials, consumables) drop out at the deconstructable check.
            if stackCount > 0
                and IsDeconstructableBagItem(bagId, slotIndex, craftingTypes) -- also rules out player-locked items
                and GetItemTraitInformation(bagId, slotIndex) ~= ITEM_TRAIT_INFORMATION_ORNATE
                and not IsItemInArmory(bagId, slotIndex)
                and DoesItemPassFilter(bagId, slotIndex, filterType)
                and (additionalFilter == nil or additionalFilter(bagId, slotIndex, filterType))
                and not (processed and processed[Id64ToString(GetItemUniqueId(bagId, slotIndex))])
            then
                count = count + 1
                if onItem and onItem(bagId, slotIndex, stackCount) == false then
                    return count
                end
                if count >= limit then
                    return count
                end
            end
        end
    end
    return count
end

----------------------------------
-- Run loop
----------------------------------

function DisassembleAll:UpdateKeybind()
    local panelOwner = UNIVERSAL_DECONSTRUCTION
    if panelOwner and panelOwner.keybindStripDescriptor then
        KEYBIND_STRIP:UpdateKeybindButtonGroup(panelOwner.keybindStripDescriptor)
    end
end

function DisassembleAll:SendNextBatch()
    if not self.isRunning then
        return
    end

    local maxSlots = zo_min(BATCH_LIMIT, MAX_ITEM_SLOTS_PER_DECONSTRUCTION or BATCH_LIMIT)
    local maxIterations = MAX_ITERATIONS_PER_DECONSTRUCTION or NO_LIMIT
    local processed = self.processed
    local added, iterations = 0, 0
    local addFailed = false

    PrepareDeconstructMessage()
    self:ForEachCandidate(maxSlots, function(bagId, slotIndex, stackCount)
        -- Same rule as the game: a stack above the iteration limit is only allowed on its own.
        if added > 0 and iterations + stackCount > maxIterations then
            return true -- skip, a later (smaller) item may still fit
        end
        if not AddItemToDeconstructMessage(bagId, slotIndex, stackCount) then
            addFailed = true
            return false
        end
        processed[Id64ToString(GetItemUniqueId(bagId, slotIndex))] = true
        added = added + 1
        iterations = iterations + stackCount
        return true
    end)

    if added == 0 then
        self:Finish(addFailed and SI_ESOQOL_DISASSEMBLE_STOPPED or nil)
        return
    end

    if not SendDeconstructMessage() then
        self:Finish(SI_ESOQOL_DISASSEMBLE_STOPPED)
        return
    end
    self.pendingCount = added
end

-- Waits until the server answered and the result animation finished (bounded), then sends the next batch.
function DisassembleAll:PollNext()
    if not self.isRunning then
        EVENT_MANAGER:UnregisterForUpdate(POLL_NAMESPACE)
        return
    end
    if IsAwaitingCraftingProcessResponse() then
        return
    end
    if ZO_CraftingUtils_IsPerformingCraftProcess() and GetFrameTimeMilliseconds() - self.waitStartMs < MAX_ANIMATION_WAIT_MS then
        return
    end
    EVENT_MANAGER:UnregisterForUpdate(POLL_NAMESPACE)
    self:SendNextBatch()
end

function DisassembleAll:OnCraftCompleted()
    if self.pendingCount == 0 then
        return
    end
    self.totalCount = self.totalCount + self.pendingCount
    self.pendingCount = 0
    self.waitStartMs = GetFrameTimeMilliseconds()
    EVENT_MANAGER:RegisterForUpdate(POLL_NAMESPACE, POLL_INTERVAL_MS, function() self:PollNext() end)
end

function DisassembleAll:OnCraftFailed(tradeskillResult)
    if self.pendingCount == 0 then
        return
    end
    self.pendingCount = 0
    self:Finish(SI_ESOQOL_DISASSEMBLE_FAILED, GetString("SI_TRADESKILLRESULT", tradeskillResult))
end

function DisassembleAll:Start()
    if self.isRunning or ZO_CraftingUtils_IsPerformingCraftProcess() or not UNIVERSAL_DECONSTRUCTION_KEYBOARD_SCENE:IsShowing() then
        return
    end

    self.isRunning = true
    self.pendingCount = 0
    self.totalCount = 0
    ZO_ClearTable(self.processed)

    local panel = GetPanel()
    if panel and panel:HasSelections() then
        panel:ClearSelections()
    end

    EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_CRAFT_COMPLETED, function() self:OnCraftCompleted() end)
    EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_CRAFT_FAILED, function(_, result) self:OnCraftFailed(result) end)
    EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_END_CRAFTING_STATION_INTERACT, function() self:Stop() end)

    self:UpdateKeybind()
    self:SendNextBatch()
end

-- messageId nil = finished normally.
function DisassembleAll:Finish(messageId, detail)
    if not self.isRunning then
        return
    end
    self.isRunning = false
    self.pendingCount = 0
    ZO_ClearTable(self.processed)

    EVENT_MANAGER:UnregisterForUpdate(POLL_NAMESPACE)
    EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE, EVENT_CRAFT_COMPLETED)
    EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE, EVENT_CRAFT_FAILED)
    EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE, EVENT_END_CRAFTING_STATION_INTERACT)

    if self.savedVars.chatMessage then
        addon:SystemMessage(zo_strformat(messageId or SI_ESOQOL_DISASSEMBLE_DONE, self.totalCount, detail or ""))
    end
    self:UpdateKeybind()
end

-- A batch already sent still completes on the server; only further batches are cancelled.
function DisassembleAll:Stop()
    self.totalCount = self.totalCount + self.pendingCount
    self:Finish(SI_ESOQOL_DISASSEMBLE_STOPPED)
end

function DisassembleAll:OnButtonPressed()
    if self.isRunning then
        self:Stop()
        return
    end

    local total = self:ForEachCandidate(NO_LIMIT)
    if total == 0 then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, SOUNDS.NEGATIVE_CLICK, GetString(SI_ESOQOL_DISASSEMBLE_NOTHING))
        return
    end

    if self.savedVars.confirm then
        ZO_Dialogs_ShowDialog(CONFIRM_DIALOG, nil, { mainTextParams = { ZO_CommaDelimitNumber(total) } })
    else
        self:Start()
    end
end

----------------------------------
-- UI
----------------------------------

function DisassembleAll:InstallUI()
    if self.uiInstalled then
        return
    end
    local owner = UNIVERSAL_DECONSTRUCTION
    if not (owner and owner.keybindStripDescriptor and UNIVERSAL_DECONSTRUCTION_KEYBOARD_SCENE) then
        return
    end
    self.uiInstalled = true

    ZO_Dialogs_RegisterCustomDialog(CONFIRM_DIALOG,
    {
        title = { text = SI_ESOQOL_DISASSEMBLE_ALL },
        mainText = { text = SI_ESOQOL_DISASSEMBLE_CONFIRM },
        buttons =
        {
            { text = SI_DIALOG_CONFIRM, callback = function() self:Start() end },
            { text = SI_DIALOG_CANCEL },
        },
    })

    local descriptor = owner.keybindStripDescriptor
    descriptor[#descriptor + 1] =
    {
        keybind = KEYBIND,
        name = function()
            return GetString(self.isRunning and SI_ESOQOL_DISASSEMBLE_STOP or SI_ESOQOL_DISASSEMBLE_ALL)
        end,
        callback = function() self:OnButtonPressed() end,
        visible = function() return self.savedVars.enabled end,
        enabled = function()
            return self.isRunning or not ZO_CraftingUtils_IsPerformingCraftProcess()
        end,
    }

    UNIVERSAL_DECONSTRUCTION_KEYBOARD_SCENE:RegisterCallback("StateChange", function(_, newState)
        if newState == SCENE_HIDDEN and self.isRunning then
            self:Stop()
        end
    end)
end

function DisassembleAll:SetEnabled(enabled)
    self.savedVars.enabled = enabled
    if not enabled and self.isRunning then
        self:Stop()
    end
    self:UpdateKeybind()
end

function DisassembleAll:Initialize(savedVars)
    self.savedVars = savedVars
    -- Installed even while disabled (the button is just hidden), so enabling needs no reload.
    self:InstallUI()
end

addon:RegisterModule(DisassembleAll)
