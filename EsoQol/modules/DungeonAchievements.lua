--[[
    Dungeon achievements: icons next to every dungeon in the Dungeon Finder's specific list
    (keyboard and gamepad), in the style of Bandits User Interface.

    * Normal rows:  check = normal clear.
    * Veteran rows: check = veteran clear, then hard mode and deathless.
    * An icon is only shown once its achievement is earned; nothing is shown for dungeons missing from the table.

    Performance notes:
    * Achievement ids are a static table keyed by zone id (one lookup per row, no scanning).
    * The icon markup of each row kind is built once and cached; the cache is only cleared when
      an achievement is awarded or the achievement data is refreshed by the game.
    * Keyboard rows get one lazily created label (pooled with the row); gamepad entries get the icons
      appended to their text once per list rebuild.
]]

local addon = EsoQol

local EVENT_NAMESPACE = addon.name .. "_DungeonAchievements"
local KEYBOARD_ENTRY_TEMPLATE = "ZO_ActivityFinderTemplateNavigationEntry_Keyboard"

local KEYBOARD_ICON_SIZE = 20
local GAMEPAD_ICON_SIZE = 28
-- The row text starts after the 16px check button and its 5px anchor offset.
local KEYBOARD_TEXT_OFFSET_X = 21
-- Icons line up in a column, pushed further right only by names that would reach it.
local KEYBOARD_ICON_COLUMN_X = 300
local KEYBOARD_ICON_GAP = 12

-- Same textures as Bandits User Interface.
local ICON_CLEAR = "EsoUI/Art/Cadwell/check.dds"
local ICON_HARD_MODE = "EsoUI/Art/UnitFrames/target_veteranRank_icon.dds"
local ICON_NO_DEATH = "EsoUI/Art/TreeIcons/gamepad/gp_tutorial_idexicon_death.dds"

local NORMAL, VETERAN, HARD_MODE, NO_DEATH = 1, 2, 3, 4

-- [zoneId] = { normal, veteran, hard mode, deathless } achievement ids.
-- Source: Bandits User Interface / LibSets dungeon data.
local DUNGEON_ACHIEVEMENTS =
{
    [148] = { 272, 1604, 1609, 1608 }, -- Arx Corinium
    [1389] = { 3468, 3469, 3470, 3472 }, -- Bal Sunnar
    [1471] = { 3851, 3852, 3853, 3855 }, -- Bedlam Veil
    [1228] = { 2831, 2832, 2833, 2835 }, -- Black Drake Villa
    [1552] = { 4334, 4335, 4336, 4338 }, -- Black Gem Foundry
    [38] = { 410, 1647, 1652, 1651 }, -- Blackheart Haven
    [64] = { 393, 1641, 1646, 1645 }, -- Blessed Crucible
    [973] = { 1690, 1691, 1696, 1695 }, -- Bloodroot Forge
    [1201] = { 2704, 2705, 2706, 2708 }, -- Castle Thorn
    [176] = { 551, 1597, 1602, 1601 }, -- City of Ash I
    [681] = { 1603, 878, 1114, 1107 }, -- City of Ash II
    [1301] = { 3104, 3105, 3153, 3108 }, -- Coral Aerie
    [848] = { 1522, 1523, 1524, 1526 }, -- Cradle of Shadows
    [130] = { 80, 1610, 1615, 1614 }, -- Crypt of Hearts I
    [932] = { 1616, 876, 1084, 942 }, -- Crypt of Hearts II
    [63] = { 78, 1581, 1586, 1585 }, -- Darkshade Caverns I
    [930] = { 1587, 464, 467, 1588 }, -- Darkshade Caverns II
    [1081] = { 2270, 2271, 2272, 2274 }, -- Depths of Malatar
    [449] = { 357, 1623, 1628, 1627 }, -- Direfrost Keep
    [1360] = { 3375, 3376, 3377, 3379 }, -- Earthen Root Enclave
    [126] = { 11, 1573, 1578, 1577 }, -- Elden Hollow I
    [931] = { 1579, 459, 463, 1580 }, -- Elden Hollow II
    [1496] = { 4109, 4110, 4111, 4113 }, -- Exiled Redoubt
    [974] = { 1698, 1699, 1704, 1703 }, -- Falkreath Hold
    [1009] = { 1959, 1960, 1965, 1964 }, -- Fang Lair
    [1080] = { 2260, 2261, 2262, 2264 }, -- Frostvault
    [283] = { 294, 1556, 1561, 1560 }, -- Fungal Grotto I
    [934] = { 1562, 343, 342, 1563 }, -- Fungal Grotto II
    [1361] = { 3394, 3395, 3396, 3398 }, -- Graven Deep
    [1152] = { 2539, 2540, 2541, 2543 }, -- Icereach
    [678] = { 1345, 880, 1303, 1129 }, -- Imperial City Prison
    [1123] = { 2425, 2426, 2427, 2429 }, -- Lair of Maarselok
    [1497] = { 4128, 4129, 4130, 4132 }, -- Lep Seclusa
    [1055] = { 2162, 2163, 2164, 2166 }, -- March of Sacrifices
    [1052] = { 2152, 2153, 2154, 2156 }, -- Moon Hunter Keep
    [1122] = { 2415, 2416, 2417, 2419 }, -- Moongrave Fane
    [1551] = { 4311, 4312, 4313, 4315 }, -- Naj-Caldeesh
    [1470] = { 3810, 3811, 3812, 3814 }, -- Oathsworn Pit
    [1267] = { 3016, 3017, 3018, 3020 }, -- Red Petal Bastion
    [843] = { 1504, 1505, 1506, 1508 }, -- Ruins of Mazzatun
    [1010] = { 1975, 1976, 1981, 1980 }, -- Scalecaller Peak
    [1390] = { 3529, 3530, 3531, 3533 }, -- Scrivener's Hall
    [31] = { 417, 1635, 1640, 1639 }, -- Selene's Web
    [1302] = { 3114, 3115, 3154, 3118 }, -- Shipwright's Regret
    [144] = { 301, 1565, 1570, 1569 }, -- Spindleclutch I
    [936] = { 1571, 421, 448, 1572 }, -- Spindleclutch II
    [1197] = { 2694, 2695, 2755, 2698 }, -- Stone Garden
    [131] = { 81, 1617, 1622, 1621 }, -- Tempest Island
    [380] = { 325, 1549, 1554, 1553 }, -- The Banished Cells I
    [935] = { 1555, 545, 451, 1564 }, -- The Banished Cells II
    [1229] = { 2841, 2842, 2843, 2845 }, -- The Cauldron
    [1268] = { 3026, 3027, 3028, 3030 }, -- The Dread Cellar
    [1153] = { 2549, 2550, 2551, 2553 }, -- Unhallowed Grave
    [11] = { 570, 1653, 1658, 1657 }, -- Vaults of Madness
    [22] = { 391, 1629, 1634, 1633 }, -- Volenfell
    [146] = { 79, 1589, 1594, 1593 }, -- Wayrest Sewers I
    [933] = { 1595, 678, 681, 1596 }, -- Wayrest Sewers II
    [688] = { 1346, 1120, 1279, 1276 }, -- White-Gold Tower
}

local DungeonAchievements =
{
    savedVarsKey = "dungeonAchievements",
    isEnabled = false,
    keyboardCache = {},  -- [zoneId] = markup for normal rows, [-zoneId] = markup for veteran rows
    gamepadCache = {},
}
addon.DungeonAchievements = DungeonAchievements

----------------------------------
-- Icon markup
----------------------------------

local function BuildIconText(ids, isVeteran, size)
    local icons = {}
    local function AddIcon(achievementId, texture)
        if achievementId and IsAchievementComplete(achievementId) then
            icons[#icons + 1] = zo_iconFormat(texture, size, size)
        end
    end

    if isVeteran then
        AddIcon(ids[VETERAN], ICON_CLEAR)
        AddIcon(ids[HARD_MODE], ICON_HARD_MODE)
        AddIcon(ids[NO_DEATH], ICON_NO_DEATH)
    else
        AddIcon(ids[NORMAL], ICON_CLEAR)
    end
    return table.concat(icons)
end

-- Returns the (possibly empty) icon markup for a finder location; "" for anything that isn't a known dungeon.
function DungeonAchievements:GetIconText(location, cache, size)
    if type(location) ~= "table" or location.GetZoneId == nil then
        return ""
    end
    local zoneId = location:GetZoneId()
    local ids = DUNGEON_ACHIEVEMENTS[zoneId]
    if not ids then
        return ""
    end

    local isVeteran = location:GetActivityType() == LFG_ACTIVITY_MASTER_DUNGEON
    local key = isVeteran and -zoneId or zoneId
    local text = cache[key]
    if not text then
        text = BuildIconText(ids, isVeteran, size)
        cache[key] = text
    end
    return text
end

function DungeonAchievements:ClearCache()
    ZO_ClearTable(self.keyboardCache)
    ZO_ClearTable(self.gamepadCache)
end

----------------------------------
-- Keyboard rows
----------------------------------

function DungeonAchievements:SetupKeyboardRow(control, location)
    local text = self.isEnabled and self:GetIconText(location, self.keyboardCache, KEYBOARD_ICON_SIZE) or ""
    local label = control.esoQolAchievements
    if text == "" then
        if label then
            label:SetHidden(true)
        end
        return
    end

    if not label then
        label = WINDOW_MANAGER:CreateControl(nil, control, CT_LABEL)
        label:SetFont("ZoFontGameLarge")
        label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
        control.esoQolAchievements = label
    end

    local offsetX = zo_max(KEYBOARD_ICON_COLUMN_X, KEYBOARD_TEXT_OFFSET_X + control.text:GetTextWidth() + KEYBOARD_ICON_GAP)
    label:ClearAnchors()
    label:SetAnchor(LEFT, control, LEFT, offsetX, 0)
    label:SetText(text)
    label:SetHidden(false)
end

----------------------------------
-- Gamepad list
----------------------------------

-- Entries are recreated on every RefreshView, so the icons are appended to the text afterwards.
function DungeonAchievements:DecorateGamepadList(finder)
    if not self.isEnabled then
        return
    end

    local list = finder.entryList
    local changed = false
    for index = 1, list:GetNumEntries() do
        local entryData = list:GetEntryData(index)
        local location = entryData and entryData.data
        if location and not location.isRoleSelector and not entryData.esoQolAchievements then
            local text = self:GetIconText(location, self.gamepadCache, GAMEPAD_ICON_SIZE)
            if text ~= "" then
                entryData:SetText(string.format("%s  %s", entryData.text, text))
                entryData.esoQolAchievements = true
                changed = true
            end
        end
    end

    if changed then
        list:RefreshVisible()
    end
end

----------------------------------
-- Hooks / events
----------------------------------

function DungeonAchievements:InstallHooks()
    if self.hooksInstalled then
        return
    end
    self.hooksInstalled = true

    local keyboardFinder = DUNGEON_FINDER_KEYBOARD
    local tree = keyboardFinder and keyboardFinder.navigationTree
    local templateInfo = tree and tree.templateInfo and tree.templateInfo[KEYBOARD_ENTRY_TEMPLATE]
    if templateInfo and templateInfo.setupFunction then
        -- Nodes copy the setup function when created (only on RefreshView), so wrapping at load covers every row.
        local originalSetup = templateInfo.setupFunction
        templateInfo.setupFunction = function(node, control, data, ...)
            originalSetup(node, control, data, ...)
            self:SetupKeyboardRow(control, data)
        end
    end

    local gamepadFinder = DUNGEON_FINDER_GAMEPAD
    if gamepadFinder then
        SecurePostHook(gamepadFinder, "RefreshView", function(finder)
            self:DecorateGamepadList(finder)
        end)
    end
end

function DungeonAchievements:OnAchievementsChanged()
    self:ClearCache()
    addon:RefreshDungeonFinderViews()
end

function DungeonAchievements:SetEnabled(enabled)
    if self.isEnabled == enabled then
        return
    end
    self.isEnabled = enabled
    self:ClearCache()

    if enabled then
        self:InstallHooks()
        local function OnAchievementsChanged()
            self:OnAchievementsChanged()
        end
        EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_ACHIEVEMENT_AWARDED, OnAchievementsChanged)
        EVENT_MANAGER:RegisterForEvent(EVENT_NAMESPACE, EVENT_ACHIEVEMENTS_UPDATED, OnAchievementsChanged)
    else
        EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE, EVENT_ACHIEVEMENT_AWARDED)
        EVENT_MANAGER:UnregisterForEvent(EVENT_NAMESPACE, EVENT_ACHIEVEMENTS_UPDATED)
    end
    addon:RefreshDungeonFinderViews()
end

function DungeonAchievements:Initialize(savedVars)
    self.savedVars = savedVars
    self:SetEnabled(savedVars.enabled)
end

addon:RegisterModule(DungeonAchievements)
