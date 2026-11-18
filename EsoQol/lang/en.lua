local strings =
{
    -- Keybindings
    SI_BINDING_NAME_ESOQOL_COMPANION_WHEEL = "Companion Wheel",
    SI_BINDING_NAME_ESOQOL_ASSISTANT_WHEEL = "Assistant Wheel",

    -- Wheels
    SI_ESOQOL_WHEEL_EMPTY_COMPANIONS = "You have no unlocked companions.",
    SI_ESOQOL_WHEEL_EMPTY_ASSISTANTS = "You have no unlocked assistants.",
    SI_ESOQOL_REASON_COMPANION_PENDING = "A companion is already being summoned.",
    SI_ESOQOL_REASON_COMPANION_QUEST = "Complete this companion's introductory quest first.",
    SI_ESOQOL_REASON_COOLDOWN = "On cooldown: <<1>>",
    SI_ESOQOL_REASON_UNAVAILABLE = "Can't be summoned right now.",
    SI_ESOQOL_CHAT_SUMMON = "Summoning <<1>>.",
    SI_ESOQOL_CHAT_DISMISS = "Dismissing <<1>>.",

    -- Pledges
    SI_ESOQOL_PLEDGE_MARKED = "Undaunted pledge: |cFFFFFF<<1>>|r marked in the Dungeon Finder.",
    SI_ESOQOL_PLEDGE_NOT_FOUND = "Undaunted pledge: no Dungeon Finder entry found for |cFFFFFF<<1>>|r.",

    -- Settings
    SI_ESOQOL_SETTINGS_COMPANION_HEADER = "Companion Wheel",
    SI_ESOQOL_SETTINGS_ASSISTANT_HEADER = "Assistant Wheel",
    SI_ESOQOL_SETTINGS_WHEEL_DESC = "Hold the key bound in Controls > Keybindings > ESO QoL to open the wheel, move the mouse to an entry and release the key to summon it. Entries that can't be summoned right now are greyed out.",
    SI_ESOQOL_SETTINGS_ENABLED = "Enabled",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE = "Hide unavailable entries",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE_TT = "Hide entries that can't be summoned instead of showing them greyed out.",
    SI_ESOQOL_SETTINGS_TAP_ACTION = "Tap key to summon / dismiss last used",
    SI_ESOQOL_SETTINGS_CHAT_MESSAGE = "Chat message on summon / dismiss",
    SI_ESOQOL_SETTINGS_TAP_ACTION_TT ="A short tap of the wheel key summons (or dismisses, if it is out) the entry you used last, without opening the wheel.",

    SI_ESOQOL_SETTINGS_PLEDGES_HEADER = "Undaunted Pledges",
    SI_ESOQOL_SETTINGS_PLEDGES_DESC = "When you accept an Undaunted pledge, its dungeon is checked in the Dungeon Finder's specific dungeon list. It is unchecked again when the pledge is completed or abandoned.",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY = "Difficulty to mark",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_AUTO = "Auto (veteran from CP 160)",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_NORMAL = "Normal",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_VETERAN = "Veteran",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC = "Open specific dungeon list",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC_TT = "While you have a pledge, the Dungeon Finder opens on the specific dungeon list instead of the random dungeon.",
    SI_ESOQOL_SETTINGS_PLEDGES_MARKER = "Quest marker in dungeon list",
    SI_ESOQOL_SETTINGS_PLEDGES_MARKER_TT = "Shows a quest marker next to dungeons you have a pledge for in the Dungeon Finder list.",
    SI_ESOQOL_SETTINGS_PLEDGES_NOTIFY = "Chat notification",

    SI_ESOQOL_SETTINGS_INTRO_HEADER = "Game Start",
    SI_ESOQOL_SETTINGS_INTRO_SKIP = "Skip intro videos",
    SI_ESOQOL_SETTINGS_INTRO_SKIP_TT = "Skips the logo and intro videos when the game starts. Takes effect from the next game launch.",
}

for stringId, text in pairs(strings) do
    ZO_CreateStringId(stringId, text)
    SafeAddVersion(stringId, 1)
end
