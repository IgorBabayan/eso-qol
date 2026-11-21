EsoQol = EsoQol or {}

local addon = EsoQol
addon.name = "EsoQol"
addon.displayName = "ESO QoL"
addon.version = "1.0.0"

local SAVED_VARS_VERSION = 1

addon.defaults =
{
    companionWheel =
    {
        enabled = true,
        hideUnavailable = false,
        tapToggleLast = true,
        chatMessage = true,
        lastCollectibleId = 0,
    },
    assistantWheel =
    {
        enabled = true,
        hideUnavailable = false,
        tapToggleLast = true,
        chatMessage = true,
        lastCollectibleId = 0,
    },
    pledges =
    {
        enabled = true,
        difficulty = "auto", -- "auto" | "normal" | "veteran"
        openSpecificList = true,
        highlightDungeon = true,
        notify = true,
    },
    dungeonAchievements =
    {
        enabled = true,
    },
    skipIntro =
    {
        enabled = true,
        appliedByAddon = false,
    },
    disassembleAll =
    {
        enabled = true,
        confirm = true,
        chatMessage = true,
    },
    confirmText =
    {
        enabled = true,
    },
    hotkeys =
    {
        teleportOutside = false,
        teleportChatMessage = true,
        defaultsApplied = {}, -- [actionName] = true once the default key was offered
    },
}

-- Modules register themselves at file load; they are initialized in manifest order once saved vars are ready.
addon.modules = {}

function addon:RegisterModule(module)
    self.modules[#self.modules + 1] = module
end

function addon:SystemMessage(text)
    if CHAT_ROUTER then
        CHAT_ROUTER:AddSystemMessage(text)
    end
end

-- Redraws the Dungeon Finder list when it is on screen (no-op while it is closed).
function addon:RefreshDungeonFinderViews()
    local keyboardFinder = DUNGEON_FINDER_KEYBOARD
    if keyboardFinder and keyboardFinder.fragment and keyboardFinder.fragment:IsShowing() then
        keyboardFinder:RefreshView()
    end
    local gamepadFinder = DUNGEON_FINDER_GAMEPAD
    if gamepadFinder and gamepadFinder:IsShowing() then
        gamepadFinder:RefreshView()
    end
end

local function OnAddOnLoaded(_, addOnName)
    if addOnName ~= addon.name then
        return
    end
    EVENT_MANAGER:UnregisterForEvent(addon.name, EVENT_ADD_ON_LOADED)

    addon.sv = ZO_SavedVars:NewAccountWide("EsoQol_SV", SAVED_VARS_VERSION, nil, addon.defaults)

    for _, module in ipairs(addon.modules) do
        module:Initialize(addon.sv[module.savedVarsKey])
    end

    addon:InitializeSettings()
end

EVENT_MANAGER:RegisterForEvent(addon.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
