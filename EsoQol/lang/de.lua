-- Deutsch. Overrides the English strings from lang/en.lua; anything missing here stays English.
local strings =
{
    -- Keybindings
    SI_BINDING_NAME_ESOQOL_COMPANION_WHEEL = "Begleiter-Rad",
    SI_BINDING_NAME_ESOQOL_ASSISTANT_WHEEL = "Assistenten-Rad",
    SI_BINDING_NAME_ESOQOL_RELOAD_UI = "Benutzeroberfläche neu laden",
    SI_BINDING_NAME_ESOQOL_TELEPORT_HOME = "Zum Hauptwohnsitz teleportieren",

    -- Hotkeys
    SI_ESOQOL_HOTKEY_NO_PRIMARY_HOUSE = "Ihr habt keinen Hauptwohnsitz festgelegt.",
    SI_ESOQOL_HOTKEY_IN_COMBAT = "Im Kampf könnt Ihr nicht nach Hause reisen.",
    SI_ESOQOL_HOTKEY_TELEPORTING = "Reise nach <<1>>.",
    SI_ESOQOL_HOTKEY_KEY_IN_USE = "ESO QoL: <<2>> wird bereits von einer anderen Aktion verwendet, daher wurde „<<1>>“ nicht belegt. Legt die Taste unter Steuerung > Tastenbelegung > ESO QoL fest.",

    -- Wheels
    SI_ESOQOL_WHEEL_EMPTY_COMPANIONS = "Ihr habt keine freigeschalteten Begleiter.",
    SI_ESOQOL_WHEEL_EMPTY_ASSISTANTS = "Ihr habt keine freigeschalteten Assistenten.",
    SI_ESOQOL_REASON_COMPANION_PENDING = "Es wird bereits ein Begleiter herbeigerufen.",
    SI_ESOQOL_REASON_COMPANION_QUEST = "Schließt zuerst die Einführungsquest dieses Begleiters ab.",
    SI_ESOQOL_REASON_COOLDOWN = "Abklingzeit: <<1>>",
    SI_ESOQOL_REASON_UNAVAILABLE = "Kann gerade nicht herbeigerufen werden.",
    SI_ESOQOL_CHAT_SUMMON = "Rufe <<1>> herbei.",
    SI_ESOQOL_CHAT_DISMISS = "Entlasse <<1>>.",

    -- Pledges
    SI_ESOQOL_PLEDGE_MARKED = "Gelöbnis der Unerschrockenen: |cFFFFFF<<1>>|r in der Gruppensuche markiert.",
    SI_ESOQOL_PLEDGE_NOT_FOUND = "Gelöbnis der Unerschrockenen: kein Eintrag in der Gruppensuche für |cFFFFFF<<1>>|r gefunden.",
    SI_ESOQOL_PLEDGE_READY = "Gelöbnis der Unerschrockenen: |cFFFFFF<<1>>|r erledigt, Markierung in der Gruppensuche entfernt. Kehrt zum Auftraggeber zurück.",

    -- Disassemble All (Giladil the Ragpicker)
    SI_ESOQOL_DISASSEMBLE_ALL = "Alles zerlegen",
    SI_ESOQOL_DISASSEMBLE_STOP = "Zerlegen stoppen",
    SI_ESOQOL_DISASSEMBLE_CONFIRM = "Gegenstände aus der Liste zerlegen: <<1>>? Gegenstände mit der Eigenschaft „Prunkvoll“, gesperrte Gegenstände und Gegenstände in Waffenkammer-Builds werden übersprungen.",
    SI_ESOQOL_DISASSEMBLE_NOTHING = "Nichts zu zerlegen.",
    SI_ESOQOL_DISASSEMBLE_DONE = "Alles zerlegen: <<1>> Gegenstände zerlegt.",
    SI_ESOQOL_DISASSEMBLE_STOPPED = "Alles zerlegen: nach <<1>> Gegenständen angehalten.",
    SI_ESOQOL_DISASSEMBLE_FAILED = "Alles zerlegen: nach <<1>> Gegenständen angehalten (<<2>>).",

    -- Settings
    SI_ESOQOL_SETTINGS_COMPANION_HEADER = "Begleiter-Rad",
    SI_ESOQOL_SETTINGS_ASSISTANT_HEADER = "Assistenten-Rad",
    SI_ESOQOL_SETTINGS_WHEEL_DESC = "Haltet die unter Steuerung > Tastenbelegung > ESO QoL festgelegte Taste gedrückt, um das Rad zu öffnen, bewegt die Maus auf einen Eintrag und lasst die Taste los, um ihn herbeizurufen. Einträge, die gerade nicht herbeigerufen werden können, sind ausgegraut.",
    SI_ESOQOL_SETTINGS_ENABLED = "Aktiviert",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE = "Nicht verfügbare Einträge ausblenden",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE_TT = "Blendet Einträge, die nicht herbeigerufen werden können, aus, statt sie ausgegraut anzuzeigen.",
    SI_ESOQOL_SETTINGS_TAP_ACTION = "Kurz tippen: zuletzt genutzten herbeirufen / entlassen",
    SI_ESOQOL_SETTINGS_CHAT_MESSAGE = "Chatnachricht beim Herbeirufen / Entlassen",
    SI_ESOQOL_SETTINGS_TAP_ACTION_TT = "Ein kurzes Antippen der Rad-Taste ruft den zuletzt genutzten Eintrag herbei (oder entlässt ihn, wenn er bereits da ist), ohne das Rad zu öffnen.",

    SI_ESOQOL_SETTINGS_PLEDGES_HEADER = "Gelöbnisse der Unerschrockenen",
    SI_ESOQOL_SETTINGS_PLEDGES_DESC = "Wenn Ihr ein Gelöbnis der Unerschrockenen annehmt, wird dessen Verlies in der Liste bestimmter Verliese der Gruppensuche angehakt. Der Haken wird wieder entfernt, sobald das Gelöbnis erledigt ist und nur noch abgegeben werden muss oder wenn es abgebrochen wird.",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY = "Zu markierender Schwierigkeitsgrad",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_AUTO = "Automatisch (Veteran ab CP 160)",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_NORMAL = "Normal",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_VETERAN = "Veteran",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC = "Liste bestimmter Verliese öffnen",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC_TT = "Solange Ihr ein Gelöbnis habt, öffnet sich die Gruppensuche mit der Liste bestimmter Verliese statt mit dem zufälligen Verlies.",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT = "Gelöbnis-Verliese hervorheben",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT_TT = "Zeigt die Namen von Verliesen, für die Ihr ein Gelöbnis habt, in der Liste der Gruppensuche in Hellblau an.",
    SI_ESOQOL_SETTINGS_PLEDGES_NOTIFY = "Chat-Benachrichtigung",

    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_HEADER = "Verlieserfolge",
    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_DESC = "Symbole neben jedem Verlies in der Liste bestimmter Verliese der Gruppensuche zeigen Eure errungenen Erfolge: ein Haken in normalen Zeilen für den normalen Abschluss; ein Haken sowie Symbole für den schweren Modus und den Abschluss ohne Tod in Veteranen-Zeilen. Symbole für nicht errungene Erfolge werden ausgeblendet.",

    SI_ESOQOL_SETTINGS_INTRO_HEADER = "Spielstart",
    SI_ESOQOL_SETTINGS_INTRO_SKIP = "Intro-Videos überspringen",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_HEADER = "Alles zerlegen",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_DESC = "Fügt dem Verwertungsbildschirm von Giladil dem Lumpensammler eine Schaltfläche „Alles zerlegen“ hinzu. Sie verwertet alles, was in der Liste angezeigt wird (aktuelle Registerkarte, Handwerksfilter und „Gegenstände aus der Bank einbeziehen“), in Durchgängen von bis zu 100 Gegenständen, bis nichts mehr übrig ist. Prunkvolle, gesperrte und Waffenkammer-Gegenstände werden übersprungen. Erneut drücken zum Anhalten.",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CONFIRM = "Bestätigung anfordern",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CHAT = "Chatnachricht nach Abschluss",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_HEADER = "Bestätigungsdialoge",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT = "Bestätigungstext automatisch ausfüllen",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_TT = "Trägt das Wort ein, das Dialoge zur Bestätigung verlangen (z. B. beim Zerstören eines Gegenstands oder beim Verbessern gesperrter Gegenstände), in der Spielsprache und mit exakter Groß-/Kleinschreibung. Die Bestätigungsschaltfläche drückt Ihr weiterhin selbst.",
    SI_ESOQOL_SETTINGS_HOTKEYS_HEADER = "Tastenkürzel",
    SI_ESOQOL_SETTINGS_HOTKEYS_DESC = "Benutzeroberfläche neu laden (Standard: F12) und Zum Hauptwohnsitz teleportieren (Standard: Pos1). Die Tasten lassen sich unter Steuerung > Tastenbelegung > ESO QoL ändern.",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE = "Vor dem Haus ankommen",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE_TT = "Teleportiert zum Außeneingang des Hauses statt ins Innere.",
    SI_ESOQOL_SETTINGS_HOTKEYS_CHAT = "Chatnachricht beim Teleportieren",

    SI_ESOQOL_SETTINGS_INTRO_SKIP_TT = "Überspringt die Logo- und Intro-Videos beim Spielstart. Wirkt ab dem nächsten Spielstart.",

    -- Sell Ornate
    SI_ESOQOL_SELL_ORNATE_DONE = "Automatisch verkauft: <<1>> Gegenstände für <<2>>.",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_HEADER = "Prunkvolle Gegenstände automatisch verkaufen",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_DESC = "Beim Öffnen eines Händlers werden alle Gegenstände mit der Eigenschaft „Prunkvoll“ im Inventar automatisch verkauft. Gesperrte, gestohlene und Gegenstände in Waffenkammer-Builds werden übersprungen.",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_UNCOLLECTED = "Ungesammelte Setteile behalten",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_UNCOLLECTED_TT = "Prunkvolle Setgegenstände, die noch nicht in deiner Setsammlung sind, nicht verkaufen.",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_CHAT = "Chatnachricht mit Goldsumme",
    SI_ESOQOL_SETTINGS_SELL_POTIONS_HEADER = "Tränke automatisch verkaufen",
    SI_ESOQOL_SETTINGS_SELL_POTIONS_DESC = "Beim Öffnen eines Händlers werden die unten markierten Tränke automatisch verkauft, in jeder Stufe (vom Schluck bis zur Essenz). Nur die gewöhnlichen erbeuteten / gekauften Tränke; hergestellte, gesperrte und gestohlene bleiben erhalten.",
}

for stringId, text in pairs(strings) do
    SafeAddString(_G[stringId], text, 2)
end
