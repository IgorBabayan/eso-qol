local strings =
{
    -- Keybindings
    SI_BINDING_NAME_ESOQOL_COMPANION_WHEEL = "Companion Wheel",
    SI_BINDING_NAME_ESOQOL_ASSISTANT_WHEEL = "Assistant Wheel",
    SI_BINDING_NAME_ESOQOL_RELOAD_UI = "Reload UI",
    SI_BINDING_NAME_ESOQOL_TELEPORT_HOME = "Teleport to Primary House",

    -- Hotkeys
    SI_ESOQOL_HOTKEY_NO_PRIMARY_HOUSE = "You have no primary residence set.",
    SI_ESOQOL_HOTKEY_IN_COMBAT = "You can't travel home while in combat.",
    SI_ESOQOL_HOTKEY_TELEPORTING = "Travelling to <<1>>.",
    SI_ESOQOL_HOTKEY_KEY_IN_USE = "ESO QoL: <<2>> is already used by another action, so \"<<1>>\" was left unbound. Set it in Controls > Keybindings > ESO QoL.",

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

    -- Disassemble All (Giladil the Ragpicker)
    SI_ESOQOL_DISASSEMBLE_ALL = "Disassemble All",
    SI_ESOQOL_DISASSEMBLE_STOP = "Stop Disassembling",
    SI_ESOQOL_DISASSEMBLE_CONFIRM = "Disassemble <<1>> items from the list? Items with the Ornate trait, locked items and items in Armory builds are skipped.",
    SI_ESOQOL_DISASSEMBLE_NOTHING = "Nothing to disassemble.",
    SI_ESOQOL_DISASSEMBLE_DONE = "Disassemble All: <<1>> items disassembled.",
    SI_ESOQOL_DISASSEMBLE_STOPPED = "Disassemble All: stopped after <<1>> items.",
    SI_ESOQOL_DISASSEMBLE_FAILED = "Disassemble All: stopped after <<1>> items (<<2>>).",

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
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT = "Highlight pledge dungeons",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT_TT = "Shows the names of dungeons you have a pledge for in light blue in the Dungeon Finder list.",
    SI_ESOQOL_SETTINGS_PLEDGES_NOTIFY = "Chat notification",

    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_HEADER = "Dungeon Achievements",
    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_DESC = "Icons next to each dungeon in the Dungeon Finder's specific dungeon list show the achievements you have earned: a check on normal rows for the normal clear; a check, hard mode and deathless icon on veteran rows. Icons for achievements you haven't earned are hidden.",

    SI_ESOQOL_SETTINGS_INTRO_HEADER = "Game Start",
    SI_ESOQOL_SETTINGS_INTRO_SKIP = "Skip intro videos",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_HEADER = "Disassemble All",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_DESC = "Adds a \"Disassemble All\" button to Giladil the Ragpicker's deconstruction screen. It deconstructs everything shown in the list (current tab, crafting type filter and \"Include banked items\") in batches of up to 100 until nothing is left. Ornate, locked and Armory items are skipped. Press it again to stop.",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CONFIRM = "Ask for confirmation",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CHAT = "Chat message when done",
    SI_ESOQOL_SETTINGS_HOTKEYS_HEADER = "Hotkeys",
    SI_ESOQOL_SETTINGS_HOTKEYS_DESC = "Reload UI (default F12) and Teleport to Primary House (default Home). Change the keys in Controls > Keybindings > ESO QoL.",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE = "Arrive outside the house",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE_TT = "Teleport to the house's outdoor entrance instead of inside.",
    SI_ESOQOL_SETTINGS_HOTKEYS_CHAT = "Chat message on teleport",

    SI_ESOQOL_SETTINGS_INTRO_SKIP_TT = "Skips the logo and intro videos when the game starts. Takes effect from the next game launch.",
}

for stringId, text in pairs(strings) do
    ZO_CreateStringId(stringId, text)
    SafeAddVersion(stringId, 1)
end
