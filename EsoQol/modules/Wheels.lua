local addon = EsoQol

local EVENT_NAMESPACE = addon.name .. "_Wheels"

-- Owns two saved-var sections (companionWheel / assistantWheel), so it reads addon.sv directly.
local Wheels =
{
    wheels = {},
}
addon.Wheels = Wheels

function Wheels:Initialize()
    local sv = addon.sv

    self.wheels.companion = addon.CollectibleWheel:New(EsoQol_CompanionWheel,
    {
        categoryType = COLLECTIBLE_CATEGORY_TYPE_COMPANION,
        emptyText = GetString(SI_ESOQOL_WHEEL_EMPTY_COMPANIONS),
        isCompanion = true,
    })
    self.wheels.companion:SetSavedVars(sv.companionWheel)

    self.wheels.assistant = addon.CollectibleWheel:New(EsoQol_AssistantWheel,
    {
        categoryType = COLLECTIBLE_CATEGORY_TYPE_ASSISTANT,
        emptyText = GetString(SI_ESOQOL_WHEEL_EMPTY_ASSISTANTS),
        isCompanion = false,
    })
    self.wheels.assistant:SetSavedVars(sv.assistantWheel)

    -- Cache invalidation only flips a flag; the rebuild happens lazily on the next open.
    local function MarkAllDirty()
        for _, wheel in pairs(self.wheels) do
            wheel:MarkCacheDirty()
        end
    end
    EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_COLLECTIBLES_UNLOCK_STATE_CHANGED, MarkAllDirty)
    EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_COLLECTION_UPDATED, MarkAllDirty)
    -- EVENT_COLLECTIBLE_UPDATED is deliberately not used: it fires on every summon/dismiss,
    -- and usability is evaluated fresh on each open anyway.

    local function CancelAll()
        for _, wheel in pairs(self.wheels) do
            wheel:Cancel()
        end
    end
    EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_GAMEPAD_PREFERRED_MODE_CHANGED, CancelAll)
    EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_PLAYER_DEACTIVATED, CancelAll)
end

-- Called from Bindings.xml
function Wheels.OnKeyDown(wheelName)
    local wheel = Wheels.wheels[wheelName]
    if wheel then
        wheel:OnKeyDown()
    end
end

function Wheels.OnKeyUp(wheelName)
    local wheel = Wheels.wheels[wheelName]
    if wheel then
        wheel:OnKeyUp()
    end
end

addon:RegisterModule(Wheels)
