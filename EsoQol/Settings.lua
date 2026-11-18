local addon = EsoQol

local function WheelOptions(controls, headerStringId, savedVarsKey, defaults)
    local function SV()
        return addon.sv[savedVarsKey]
    end

    controls[#controls + 1] = { type = "header", name = GetString(headerStringId) }
    controls[#controls + 1] = { type = "description", text = GetString(SI_ESOQOL_SETTINGS_WHEEL_DESC) }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_ENABLED),
        getFunc = function() return SV().enabled end,
        setFunc = function(value) SV().enabled = value end,
        default = defaults.enabled,
    }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE),
        tooltip = GetString(SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE_TT),
        getFunc = function() return SV().hideUnavailable end,
        setFunc = function(value) SV().hideUnavailable = value end,
        disabled = function() return not SV().enabled end,
        default = defaults.hideUnavailable,
    }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_TAP_ACTION),
        tooltip = GetString(SI_ESOQOL_SETTINGS_TAP_ACTION_TT),
        getFunc = function() return SV().tapToggleLast end,
        setFunc = function(value) SV().tapToggleLast = value end,
        disabled = function() return not SV().enabled end,
        default = defaults.tapToggleLast,
    }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_CHAT_MESSAGE),
        getFunc = function() return SV().chatMessage end,
        setFunc = function(value) SV().chatMessage = value end,
        disabled = function() return not SV().enabled end,
        default = defaults.chatMessage,
    }
end

function addon:InitializeSettings()
    SLASH_COMMANDS["/esoqol"] = function()
        if self.settingsPanel and LibAddonMenu2 then
            LibAddonMenu2:OpenToPanel(self.settingsPanel)
        end
    end

    local LAM = LibAddonMenu2
    if not LAM then
        return
    end

    local defaults = self.defaults
    local panelData =
    {
        type = "panel",
        name = self.displayName,
        displayName = self.displayName,
        author = "IgorBabayan",
        version = self.version,
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local controls = {}

    -- 1 & 2: wheels
    WheelOptions(controls, SI_ESOQOL_SETTINGS_COMPANION_HEADER, "companionWheel", defaults.companionWheel)
    WheelOptions(controls, SI_ESOQOL_SETTINGS_ASSISTANT_HEADER, "assistantWheel", defaults.assistantWheel)

    -- 3: Undaunted pledges
    local pledgeSV = function() return self.sv.pledges end
    local pledgeDisabled = function() return not pledgeSV().enabled end
    controls[#controls + 1] = { type = "header", name = GetString(SI_ESOQOL_SETTINGS_PLEDGES_HEADER) }
    controls[#controls + 1] = { type = "description", text = GetString(SI_ESOQOL_SETTINGS_PLEDGES_DESC) }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_ENABLED),
        getFunc = function() return pledgeSV().enabled end,
        setFunc = function(value)
            pledgeSV().enabled = value
            self.Pledges:SetEnabled(value)
        end,
        default = defaults.pledges.enabled,
    }
    controls[#controls + 1] =
    {
        type = "dropdown",
        name = GetString(SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY),
        choices =
        {
            GetString(SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_AUTO),
            GetString(SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_NORMAL),
            GetString(SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_VETERAN),
        },
        choicesValues = { "auto", "normal", "veteran" },
        getFunc = function() return pledgeSV().difficulty end,
        setFunc = function(value) pledgeSV().difficulty = value end,
        disabled = pledgeDisabled,
        default = defaults.pledges.difficulty,
    }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC),
        tooltip = GetString(SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC_TT),
        getFunc = function() return pledgeSV().openSpecificList end,
        setFunc = function(value) pledgeSV().openSpecificList = value end,
        disabled = pledgeDisabled,
        default = defaults.pledges.openSpecificList,
    }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_PLEDGES_MARKER),
        tooltip = GetString(SI_ESOQOL_SETTINGS_PLEDGES_MARKER_TT),
        getFunc = function() return pledgeSV().showQuestMarker end,
        setFunc = function(value)
            pledgeSV().showQuestMarker = value
            self.Pledges:RefreshFinderViews()
        end,
        disabled = pledgeDisabled,
        default = defaults.pledges.showQuestMarker,
    }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_PLEDGES_NOTIFY),
        getFunc = function() return pledgeSV().notify end,
        setFunc = function(value) pledgeSV().notify = value end,
        disabled = pledgeDisabled,
        default = defaults.pledges.notify,
    }

    -- 4: game start
    controls[#controls + 1] = { type = "header", name = GetString(SI_ESOQOL_SETTINGS_INTRO_HEADER) }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_INTRO_SKIP),
        tooltip = GetString(SI_ESOQOL_SETTINGS_INTRO_SKIP_TT),
        getFunc = function() return self.sv.skipIntro.enabled end,
        setFunc = function(value) self.SkipIntro:SetEnabled(value) end,
        default = defaults.skipIntro.enabled,
    }

    -- 5: hotkeys
    local hotkeySV = function() return self.sv.hotkeys end
    controls[#controls + 1] = { type = "header", name = GetString(SI_ESOQOL_SETTINGS_HOTKEYS_HEADER) }
    controls[#controls + 1] = { type = "description", text = GetString(SI_ESOQOL_SETTINGS_HOTKEYS_DESC) }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE),
        tooltip = GetString(SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE_TT),
        getFunc = function() return hotkeySV().teleportOutside end,
        setFunc = function(value) hotkeySV().teleportOutside = value end,
        default = defaults.hotkeys.teleportOutside,
    }
    controls[#controls + 1] =
    {
        type = "checkbox",
        name = GetString(SI_ESOQOL_SETTINGS_HOTKEYS_CHAT),
        getFunc = function() return hotkeySV().teleportChatMessage end,
        setFunc = function(value) hotkeySV().teleportChatMessage = value end,
        default = defaults.hotkeys.teleportChatMessage,
    }

    self.settingsPanel = LAM:RegisterAddonPanel(self.name .. "_Settings", panelData)
    LAM:RegisterOptionControls(self.name .. "_Settings", controls)
end
