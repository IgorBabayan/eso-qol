--[[
    Simple hotkeys: Reload UI and Teleport to primary house.

    Default keys (F12 / Home) are created once per account through CreateDefaultActionBind, and only
    when the action is still unbound and the key is free in the General layer, so a user's own
    bindings are never overwritten and an unbound action stays unbound afterwards.
    Nothing is registered on any event: the module costs nothing until a key is pressed.
]]

local addon = EsoQol

local LAYER_GENERAL = "General"

local DEFAULT_BINDS =
{
    { action = "ESOQOL_RELOAD_UI", key = KEY_F12 },
    { action = "ESOQOL_TELEPORT_HOME", key = KEY_HOME },
}

local Hotkeys =
{
    savedVarsKey = "hotkeys",
}
addon.Hotkeys = Hotkeys

local function IsActionBound(actionName)
    local layerIndex, categoryIndex, actionIndex = GetActionIndicesFromName(actionName)
    if not layerIndex then
        return true -- unknown action: treat as bound so nothing is touched
    end
    for bindingIndex = 1, GetMaxBindingsPerAction() do
        local keyCode = GetActionBindingInfo(layerIndex, categoryIndex, actionIndex, bindingIndex)
        if keyCode and keyCode ~= KEY_INVALID then
            return true
        end
    end
    return false
end

local function IsKeyFree(keyCode)
    local actionName = GetActionNameFromKey(LAYER_GENERAL, keyCode)
    return actionName == nil or actionName == ""
end

function Hotkeys:ApplyDefaultBinds()
    local applied = self.savedVars.defaultsApplied
    if type(CreateDefaultActionBind) ~= "function" then
        return
    end

    for _, bind in ipairs(DEFAULT_BINDS) do
        if not applied[bind.action] then
            applied[bind.action] = true
            if not IsActionBound(bind.action) then
                if IsKeyFree(bind.key) then
                    CreateDefaultActionBind(bind.action, bind.key)
                else
                    addon:SystemMessage(zo_strformat(SI_ESOQOL_HOTKEY_KEY_IN_USE,
                        GetString(_G["SI_BINDING_NAME_" .. bind.action]), GetKeyName(bind.key)))
                end
            end
        end
    end
end

-- Called from Bindings.xml
function Hotkeys.ReloadUI()
    ReloadUI("ingame")
end

function Hotkeys.TeleportHome()
    local houseId = GetHousingPrimaryHouse()
    if not houseId or houseId == 0 then
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.NEGATIVE_CLICK, GetString(SI_ESOQOL_HOTKEY_NO_PRIMARY_HOUSE))
        return
    end

    if IsUnitInCombat("player") then
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.NEGATIVE_CLICK, GetString(SI_ESOQOL_HOTKEY_IN_COMBAT))
        return
    end

    local savedVars = Hotkeys.savedVars
    if savedVars.teleportChatMessage then
        local houseName = GetCollectibleName(GetCollectibleIdForHouse(houseId))
        addon:SystemMessage(zo_strformat(SI_ESOQOL_HOTKEY_TELEPORTING, houseName))
    end
    RequestJumpToHouse(houseId, savedVars.teleportOutside)
end

function Hotkeys:Initialize(savedVars)
    self.savedVars = savedVars
    self:ApplyDefaultBinds()
end

addon:RegisterModule(Hotkeys)
