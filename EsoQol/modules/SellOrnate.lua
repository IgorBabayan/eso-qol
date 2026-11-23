--[[
    Sell Ornate: when a merchant's store opens, every backpack item with the Ornate trait is sold
    automatically.

    Skipped:
    * locked items and items used in an Armory build,
    * stolen items (merchants don't buy them; that's the fence),
    * optionally, set pieces you haven't added to your Set Collection yet.

    Performance notes:
    * Only EVENT_OPEN_STORE is registered while idle; everything else lives only while a run is active.
    * Candidates are collected once on open from SHARED_INVENTORY's backpack cache (filled slots only),
      with the cheapest check (trait) first.
    * Items are sold one per tick so the server isn't flooded with sell requests; each slot is re-checked
      against its unique id right before selling, so nothing else is sold if the bag changed meanwhile.
    * Gold and item counts come from EVENT_SELL_RECEIPT, i.e. what the server actually paid.
]]

local addon = EsoQol

local EVENT_NAMESPACE = addon.name .. "_SellOrnate"
local TICK_NAMESPACE = EVENT_NAMESPACE .. "_Tick"
local SELL_INTERVAL_MS = 100
local RECEIPT_WAIT_MS = 3000 -- after the last sell, stop waiting for receipts after this long

local SellOrnate =
{
    savedVarsKey = "sellOrnate",
    isRunning = false,
    queue = {},       -- array of { slotIndex, uniqueId }, reused between runs
    queueSize = 0,
    nextIndex = 1,
    sentCount = 0,
    soldCount = 0,
    gold = 0,
    lastSendMs = 0,
}
addon.SellOrnate = SellOrnate

----------------------------------
-- Candidate selection
----------------------------------

local function IsCandidate(bagId, slotIndex, skipUncollected)
    if GetItemTraitInformation(bagId, slotIndex) ~= ITEM_TRAIT_INFORMATION_ORNATE then
        return false
    end
    if IsItemPlayerLocked(bagId, slotIndex) or IsItemStolen(bagId, slotIndex) or IsItemInArmory(bagId, slotIndex) then
        return false
    end
    if skipUncollected then
        local itemLink = GetItemLink(bagId, slotIndex)
        if IsItemLinkSetCollectionPiece(itemLink) and not IsItemSetCollectionPieceUnlocked(GetItemLinkItemId(itemLink)) then
            return false
        end
    end
    return true
end

function SellOrnate:BuildQueue()
    local queue = self.queue
    local size = 0
    local skipUncollected = self.savedVars.skipUncollected
    local bagCache = SHARED_INVENTORY:GetOrCreateBagCache(BAG_BACKPACK)
    for slotIndex, slotData in pairs(bagCache) do
        if (slotData.stackCount or 0) > 0 and IsCandidate(BAG_BACKPACK, slotIndex, skipUncollected) then
            size = size + 1
            local entry = queue[size]
            if entry then
                entry.slotIndex = slotIndex
                entry.uniqueId = GetItemUniqueId(BAG_BACKPACK, slotIndex)
            else
                queue[size] = { slotIndex = slotIndex, uniqueId = GetItemUniqueId(BAG_BACKPACK, slotIndex) }
            end
        end
    end
    self.queueSize = size
    return size
end

----------------------------------
-- Run loop
----------------------------------

function SellOrnate:SellNext()
    local queue = self.queue
    local skipUncollected = self.savedVars.skipUncollected
    while self.nextIndex <= self.queueSize do
        local entry = queue[self.nextIndex]
        self.nextIndex = self.nextIndex + 1
        local slotIndex = entry.slotIndex
        -- Re-validate: the slot may have been sold, moved or locked since the queue was built.
        if AreId64sEqual(GetItemUniqueId(BAG_BACKPACK, slotIndex), entry.uniqueId)
            and IsCandidate(BAG_BACKPACK, slotIndex, skipUncollected)
        then
            local _, stackCount = GetItemInfo(BAG_BACKPACK, slotIndex)
            if stackCount > 0 then
                SellInventoryItem(BAG_BACKPACK, slotIndex, stackCount)
                self.sentCount = self.sentCount + 1
                self.lastSendMs = GetFrameTimeMilliseconds()
                return true
            end
        end
    end
    return false
end

function SellOrnate:OnTick()
    if self.nextIndex <= self.queueSize and self:SellNext() then
        return
    end
    -- All sent: wait (bounded) for the remaining receipts, then report.
    if self.soldCount >= self.sentCount or GetFrameTimeMilliseconds() - self.lastSendMs > RECEIPT_WAIT_MS then
        self:Finish()
    end
end

function SellOrnate:OnSellReceipt(money)
    if not self.isRunning then
        return
    end
    self.soldCount = self.soldCount + 1
    self.gold = self.gold + (money or 0)
end

function SellOrnate:Start()
    if self.isRunning or not self.savedVars.enabled then
        return
    end
    if self:BuildQueue() == 0 then
        return
    end

    self.isRunning = true
    self.nextIndex = 1
    self.sentCount = 0
    self.soldCount = 0
    self.gold = 0
    self.lastSendMs = GetFrameTimeMilliseconds()

    EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_SELL_RECEIPT, function(_, _, _, money) self:OnSellReceipt(money) end)
    EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_CLOSE_STORE, function() self:Finish() end)

    -- First item right away, the rest on the throttled tick.
    self:SellNext()
    EVENT_MANAGER:RegisterForUpdate(TICK_NAMESPACE, SELL_INTERVAL_MS, function() self:OnTick() end)
end

function SellOrnate:Finish()
    if not self.isRunning then
        return
    end
    self.isRunning = false
    self.queueSize = 0

    EVENT_MANAGER:UnregisterForUpdate(TICK_NAMESPACE)
    EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE, EVENT_SELL_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE, EVENT_CLOSE_STORE)

    if self.savedVars.chatMessage and self.soldCount > 0 then
        addon:SystemMessage(zo_strformat(SI_ESOQOL_SELL_ORNATE_DONE, self.soldCount,
            ZO_Currency_FormatPlatform(CURT_MONEY, self.gold, ZO_CURRENCY_FORMAT_AMOUNT_ICON)))
    end
end

----------------------------------
-- Setup
----------------------------------

function SellOrnate:SetEnabled(enabled)
    self.savedVars.enabled = enabled
    if enabled then
        EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE .. "_Open", EVENT_OPEN_STORE, function() self:Start() end)
    else
        EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE .. "_Open", EVENT_OPEN_STORE)
        self:Finish()
    end
end

function SellOrnate:Initialize(savedVars)
    self.savedVars = savedVars
    self:SetEnabled(savedVars.enabled)
end

addon:RegisterModule(SellOrnate)
