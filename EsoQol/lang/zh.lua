-- 简体中文. Overrides the English strings from lang/en.lua; anything missing here stays English.
local strings =
{
    -- Keybindings
    SI_BINDING_NAME_ESOQOL_COMPANION_WHEEL = "同伴轮盘",
    SI_BINDING_NAME_ESOQOL_ASSISTANT_WHEEL = "助手轮盘",
    SI_BINDING_NAME_ESOQOL_RELOAD_UI = "重新加载界面",
    SI_BINDING_NAME_ESOQOL_TELEPORT_HOME = "传送到主要住宅",

    -- Hotkeys
    SI_ESOQOL_HOTKEY_NO_PRIMARY_HOUSE = "你尚未设置主要住宅。",
    SI_ESOQOL_HOTKEY_IN_COMBAT = "战斗中无法回家。",
    SI_ESOQOL_HOTKEY_TELEPORTING = "正在前往<<1>>。",
    SI_ESOQOL_HOTKEY_KEY_IN_USE = "ESO QoL：<<2>>已被其他操作占用，因此“<<1>>”未绑定按键。请在 控制 > 按键绑定 > ESO QoL 中设置。",

    -- Wheels
    SI_ESOQOL_WHEEL_EMPTY_COMPANIONS = "你没有已解锁的同伴。",
    SI_ESOQOL_WHEEL_EMPTY_ASSISTANTS = "你没有已解锁的助手。",
    SI_ESOQOL_REASON_COMPANION_PENDING = "已有同伴正在召唤中。",
    SI_ESOQOL_REASON_COMPANION_QUEST = "请先完成该同伴的引导任务。",
    SI_ESOQOL_REASON_COOLDOWN = "冷却中：<<1>>",
    SI_ESOQOL_REASON_UNAVAILABLE = "目前无法召唤。",
    SI_ESOQOL_CHAT_SUMMON = "正在召唤<<1>>。",
    SI_ESOQOL_CHAT_DISMISS = "正在解散<<1>>。",

    -- Pledges
    SI_ESOQOL_PLEDGE_MARKED = "无畏者誓约：已在地下城查找器中勾选|cFFFFFF<<1>>|r。",
    SI_ESOQOL_PLEDGE_NOT_FOUND = "无畏者誓约：地下城查找器中未找到|cFFFFFF<<1>>|r。",
    SI_ESOQOL_PLEDGE_READY = "无畏者誓约：|cFFFFFF<<1>>|r已完成，已在地下城查找器中取消勾选。请返回任务发布者处。",

    -- Disassemble All (Giladil the Ragpicker)
    SI_ESOQOL_DISASSEMBLE_ALL = "全部分解",
    SI_ESOQOL_DISASSEMBLE_STOP = "停止分解",
    SI_ESOQOL_DISASSEMBLE_CONFIRM = "分解列表中的<<1>>件物品？带有华丽特性的物品、已锁定的物品以及军械库配置中的物品将被跳过。",
    SI_ESOQOL_DISASSEMBLE_NOTHING = "没有可分解的物品。",
    SI_ESOQOL_DISASSEMBLE_DONE = "全部分解：已分解<<1>>件物品。",
    SI_ESOQOL_DISASSEMBLE_STOPPED = "全部分解：分解<<1>>件物品后已停止。",
    SI_ESOQOL_DISASSEMBLE_FAILED = "全部分解：分解<<1>>件物品后已停止（<<2>>）。",

    -- Settings
    SI_ESOQOL_SETTINGS_COMPANION_HEADER = "同伴轮盘",
    SI_ESOQOL_SETTINGS_ASSISTANT_HEADER = "助手轮盘",
    SI_ESOQOL_SETTINGS_WHEEL_DESC = "按住在 控制 > 按键绑定 > ESO QoL 中绑定的按键打开轮盘，将鼠标移到某一项上并松开按键即可召唤。当前无法召唤的项目显示为灰色。",
    SI_ESOQOL_SETTINGS_ENABLED = "启用",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE = "隐藏不可用的项目",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE_TT = "隐藏无法召唤的项目，而不是将其显示为灰色。",
    SI_ESOQOL_SETTINGS_TAP_ACTION = "轻按按键召唤/解散上次使用的项目",
    SI_ESOQOL_SETTINGS_CHAT_MESSAGE = "召唤/解散时发送聊天消息",
    SI_ESOQOL_SETTINGS_TAP_ACTION_TT = "轻按一下轮盘按键即可召唤上次使用的项目（如已在场则将其解散），无需打开轮盘。",

    SI_ESOQOL_SETTINGS_PLEDGES_HEADER = "无畏者誓约",
    SI_ESOQOL_SETTINGS_PLEDGES_DESC = "接受无畏者誓约后，其地下城会在地下城查找器的指定地下城列表中被勾选。当誓约完成、只需交付时，或誓约被放弃时，勾选会被取消。",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY = "要勾选的难度",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_AUTO = "自动（CP 160起为老兵）",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_NORMAL = "普通",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_VETERAN = "老兵",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC = "打开指定地下城列表",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC_TT = "当你持有誓约时，地下城查找器会打开指定地下城列表，而不是随机地下城。",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT = "高亮誓约地下城",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT_TT = "在地下城查找器列表中以浅蓝色显示你持有誓约的地下城名称。",
    SI_ESOQOL_SETTINGS_PLEDGES_NOTIFY = "聊天通知",

    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_HEADER = "地下城成就",
    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_DESC = "地下城查找器指定地下城列表中每个地下城旁的图标显示你已获得的成就：普通行显示普通通关的勾；老兵行显示勾、困难模式和无死亡图标。未获得成就的图标会被隐藏。",

    SI_ESOQOL_SETTINGS_INTRO_HEADER = "游戏启动",
    SI_ESOQOL_SETTINGS_INTRO_SKIP = "跳过开场视频",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_HEADER = "全部分解",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_DESC = "在拾荒者吉拉迪尔的分解界面添加“全部分解”按钮。它会以每批最多100件的方式分解列表中显示的所有物品（当前标签页、制作类型筛选及“包含银行物品”），直到全部分解完毕。华丽、已锁定和军械库物品会被跳过。再次按下即可停止。",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CONFIRM = "需要确认",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CHAT = "完成时发送聊天消息",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_HEADER = "确认对话框",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT = "自动填写确认文字",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_TT = "自动填入对话框要求输入的确认词（例如摧毁物品或改良已锁定物品时），使用游戏语言并保持大小写一致。确认按钮仍需你自己点击。",
    SI_ESOQOL_SETTINGS_HOTKEYS_HEADER = "快捷键",
    SI_ESOQOL_SETTINGS_HOTKEYS_DESC = "重新加载界面（默认F12）和传送到主要住宅（默认Home）。可在 控制 > 按键绑定 > ESO QoL 中更改按键。",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE = "到达住宅外",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE_TT = "传送到住宅的室外入口，而不是室内。",
    SI_ESOQOL_SETTINGS_HOTKEYS_CHAT = "传送时发送聊天消息",

    SI_ESOQOL_SETTINGS_INTRO_SKIP_TT = "游戏启动时跳过标志和开场视频。从下次启动游戏时生效。",

    -- Sell Ornate
    SI_ESOQOL_SELL_ORNATE_DONE = "自动出售：已出售 <<1>> 件，获得 <<2>>。",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_HEADER = "自动出售华丽物品",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_DESC = "打开商人商店时，背包中所有带有华丽特性的物品都会自动出售。已锁定、偷来的物品以及军械库配置中的物品会被跳过。",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_UNCOLLECTED = "保留未收集的套装部件",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_UNCOLLECTED_TT = "不出售尚未加入套装收藏的华丽套装物品。",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_CHAT = "在聊天中显示金币总额",
    SI_ESOQOL_SETTINGS_SELL_POTIONS_HEADER = "自动出售药水",
    SI_ESOQOL_SETTINGS_SELL_POTIONS_DESC = "打开商人商店时，下方勾选的药水会自动出售（所有等级）。仅限掉落或购买的通用药水；制作的、已锁定的和偷来的药水会被保留。",
}

for stringId, text in pairs(strings) do
    SafeAddString(_G[stringId], text, 2)
end
