-- Русский. Overrides the English strings from lang/en.lua; anything missing here stays English.
local strings =
{
    -- Keybindings
    SI_BINDING_NAME_ESOQOL_COMPANION_WHEEL = "Колесо компаньонов",
    SI_BINDING_NAME_ESOQOL_ASSISTANT_WHEEL = "Колесо помощников",
    SI_BINDING_NAME_ESOQOL_RELOAD_UI = "Перезагрузить интерфейс",
    SI_BINDING_NAME_ESOQOL_TELEPORT_HOME = "Телепорт в основной дом",

    -- Hotkeys
    SI_ESOQOL_HOTKEY_NO_PRIMARY_HOUSE = "У вас не выбран основной дом.",
    SI_ESOQOL_HOTKEY_IN_COMBAT = "Нельзя отправиться домой во время боя.",
    SI_ESOQOL_HOTKEY_TELEPORTING = "Перемещение: <<1>>.",
    SI_ESOQOL_HOTKEY_KEY_IN_USE = "ESO QoL: клавиша <<2>> уже занята другим действием, поэтому «<<1>>» осталось без назначения. Назначьте клавишу в разделе Управление > Назначение клавиш > ESO QoL.",

    -- Wheels
    SI_ESOQOL_WHEEL_EMPTY_COMPANIONS = "У вас нет открытых компаньонов.",
    SI_ESOQOL_WHEEL_EMPTY_ASSISTANTS = "У вас нет открытых помощников.",
    SI_ESOQOL_REASON_COMPANION_PENDING = "Компаньон уже призывается.",
    SI_ESOQOL_REASON_COMPANION_QUEST = "Сначала выполните вводное задание этого компаньона.",
    SI_ESOQOL_REASON_COOLDOWN = "Перезарядка: <<1>>",
    SI_ESOQOL_REASON_UNAVAILABLE = "Сейчас нельзя призвать.",
    SI_ESOQOL_CHAT_SUMMON = "Призыв: <<1>>.",
    SI_ESOQOL_CHAT_DISMISS = "Отзыв: <<1>>.",

    -- Pledges
    SI_ESOQOL_PLEDGE_MARKED = "Обет Неустрашимых: |cFFFFFF<<1>>|r отмечено в поиске группы.",
    SI_ESOQOL_PLEDGE_NOT_FOUND = "Обет Неустрашимых: в поиске группы не найдено подземелье |cFFFFFF<<1>>|r.",
    SI_ESOQOL_PLEDGE_READY = "Обет Неустрашимых: |cFFFFFF<<1>>|r пройдено, отметка в поиске группы снята. Вернитесь к тому, кто дал задание.",

    -- Disassemble All (Giladil the Ragpicker)
    SI_ESOQOL_DISASSEMBLE_ALL = "Разобрать всё",
    SI_ESOQOL_DISASSEMBLE_STOP = "Остановить разбор",
    SI_ESOQOL_DISASSEMBLE_CONFIRM = "Разобрать предметы из списка (<<1>> шт.)? Предметы с особенностью «Богатый», заблокированные предметы и предметы из наборов Арсенала будут пропущены.",
    SI_ESOQOL_DISASSEMBLE_NOTHING = "Нечего разбирать.",
    SI_ESOQOL_DISASSEMBLE_DONE = "Разобрать всё: разобрано предметов — <<1>>.",
    SI_ESOQOL_DISASSEMBLE_STOPPED = "Разобрать всё: остановлено, разобрано предметов — <<1>>.",
    SI_ESOQOL_DISASSEMBLE_FAILED = "Разобрать всё: остановлено, разобрано предметов — <<1>> (<<2>>).",

    -- Settings
    SI_ESOQOL_SETTINGS_COMPANION_HEADER = "Колесо компаньонов",
    SI_ESOQOL_SETTINGS_ASSISTANT_HEADER = "Колесо помощников",
    SI_ESOQOL_SETTINGS_WHEEL_DESC = "Удерживайте клавишу, назначенную в разделе Управление > Назначение клавиш > ESO QoL, чтобы открыть колесо, наведите мышь на пункт и отпустите клавишу, чтобы призвать его. Пункты, которые сейчас нельзя призвать, показаны серым.",
    SI_ESOQOL_SETTINGS_ENABLED = "Включено",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE = "Скрывать недоступные пункты",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE_TT = "Скрывает пункты, которые нельзя призвать, вместо того чтобы показывать их серым.",
    SI_ESOQOL_SETTINGS_TAP_ACTION = "Короткое нажатие: призвать / отозвать последнего",
    SI_ESOQOL_SETTINGS_CHAT_MESSAGE = "Сообщение в чат при призыве / отзыве",
    SI_ESOQOL_SETTINGS_TAP_ACTION_TT = "Короткое нажатие клавиши колеса призывает последний использованный пункт (или отзывает его, если он уже призван), не открывая колесо.",

    SI_ESOQOL_SETTINGS_PLEDGES_HEADER = "Обеты Неустрашимых",
    SI_ESOQOL_SETTINGS_PLEDGES_DESC = "Когда вы берёте обет Неустрашимых, его подземелье отмечается в списке конкретных подземелий поиска группы. Отметка снимается, когда обет выполнен и его осталось только сдать, или когда от него отказались.",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY = "Отмечаемая сложность",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_AUTO = "Авто (ветеран с 160 CP)",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_NORMAL = "Обычная",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_VETERAN = "Ветеранская",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC = "Открывать список конкретных подземелий",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC_TT = "Пока у вас есть обет, поиск группы открывается на списке конкретных подземелий, а не на случайном подземелье.",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT = "Выделять подземелья обетов",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT_TT = "Показывает названия подземелий, на которые у вас есть обет, голубым цветом в списке поиска группы.",
    SI_ESOQOL_SETTINGS_PLEDGES_NOTIFY = "Уведомление в чат",

    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_HEADER = "Достижения подземелий",
    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_DESC = "Значки рядом с каждым подземельем в списке конкретных подземелий поиска группы показывают полученные достижения: галочка в обычных строках за обычное прохождение; галочка, значок сложного режима и значок прохождения без смертей в ветеранских строках. Значки неполученных достижений скрыты.",

    SI_ESOQOL_SETTINGS_INTRO_HEADER = "Запуск игры",
    SI_ESOQOL_SETTINGS_INTRO_SKIP = "Пропускать вступительные видео",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_HEADER = "Разобрать всё",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_DESC = "Добавляет кнопку «Разобрать всё» на экран разбора у Гиладила Старьёвщика. Она разбирает всё, что показано в списке (текущая вкладка, фильтр ремесла и «Включая предметы в банке»), партиями до 100 предметов, пока ничего не останется. Богатые, заблокированные предметы и предметы Арсенала пропускаются. Нажмите ещё раз, чтобы остановить.",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CONFIRM = "Запрашивать подтверждение",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CHAT = "Сообщение в чат по завершении",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_HEADER = "Окна подтверждения",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT = "Автоввод текста подтверждения",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_TT = "Вписывает слово, которое окна просят ввести для подтверждения (например, УНИЧТОЖИТЬ при уничтожении предмета), на языке игры и в точном регистре. Кнопку подтверждения вы по-прежнему нажимаете сами.",
    SI_ESOQOL_SETTINGS_HOTKEYS_HEADER = "Горячие клавиши",
    SI_ESOQOL_SETTINGS_HOTKEYS_DESC = "Перезагрузить интерфейс (по умолчанию F12) и Телепорт в основной дом (по умолчанию Home). Клавиши меняются в разделе Управление > Назначение клавиш > ESO QoL.",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE = "Появляться снаружи дома",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE_TT = "Телепорт ко внешнему входу в дом, а не внутрь.",
    SI_ESOQOL_SETTINGS_HOTKEYS_CHAT = "Сообщение в чат при телепорте",

    SI_ESOQOL_SETTINGS_INTRO_SKIP_TT = "Пропускает логотипы и вступительные видео при запуске игры. Вступает в силу со следующего запуска.",

    -- Sell Ornate
    SI_ESOQOL_SELL_ORNATE_DONE = "Продажа богатых: продано предметов — <<1>>, получено <<2>>.",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_HEADER = "Автопродажа богатых предметов",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_DESC = "При открытии лавки торговца все предметы с особенностью «Богатый» из рюкзака продаются автоматически. Заблокированные, краденые предметы и предметы Арсенала пропускаются.",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_UNCOLLECTED = "Оставлять несобранные предметы комплектов",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_UNCOLLECTED_TT = "Не продавать богатые предметы комплектов, которых ещё нет в коллекции комплектов.",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_CHAT = "Сообщение в чат с суммой золота",
}

for stringId, text in pairs(strings) do
    SafeAddString(_G[stringId], text, 2)
end
