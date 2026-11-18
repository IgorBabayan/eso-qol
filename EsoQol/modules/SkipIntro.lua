--[[
    Skip the logo / intro videos on game start.

    Add-ons don't run before login, so this sets the client's own "SkipPregameVideos" setting
    (stored in UserSettings.txt). The pregame UI honours it from the next launch on, once the
    videos have been seen at least once (HasPlayedPregameVideo), exactly like editing the file by hand.
    The setting is only reverted on disable if this addon was the one that turned it on.
]]

local addon = EsoQol

local CVAR_SKIP_VIDEOS = "SkipPregameVideos"

local SkipIntro =
{
    savedVarsKey = "skipIntro",
}
addon.SkipIntro = SkipIntro

function SkipIntro:Apply()
    local savedVars = self.savedVars
    local isSkipping = GetCVar(CVAR_SKIP_VIDEOS) ~= "0"

    if savedVars.enabled then
        if not isSkipping then
            SetCVar(CVAR_SKIP_VIDEOS, "1")
            savedVars.appliedByAddon = true
        end
    elseif savedVars.appliedByAddon then
        if isSkipping then
            SetCVar(CVAR_SKIP_VIDEOS, "0")
        end
        savedVars.appliedByAddon = false
    end
end

function SkipIntro:SetEnabled(enabled)
    self.savedVars.enabled = enabled
    self:Apply()
end

function SkipIntro:Initialize(savedVars)
    self.savedVars = savedVars
    self:Apply()
end

addon:RegisterModule(SkipIntro)
