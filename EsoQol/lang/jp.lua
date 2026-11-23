-- 日本語. Overrides the English strings from lang/en.lua; anything missing here stays English.
local strings =
{
    -- Keybindings
    SI_BINDING_NAME_ESOQOL_COMPANION_WHEEL = "仲間ホイール",
    SI_BINDING_NAME_ESOQOL_ASSISTANT_WHEEL = "アシスタントホイール",
    SI_BINDING_NAME_ESOQOL_RELOAD_UI = "UIを再読み込み",
    SI_BINDING_NAME_ESOQOL_TELEPORT_HOME = "メインの家へテレポート",

    -- Hotkeys
    SI_ESOQOL_HOTKEY_NO_PRIMARY_HOUSE = "メインの家が設定されていません。",
    SI_ESOQOL_HOTKEY_IN_COMBAT = "戦闘中は家に移動できません。",
    SI_ESOQOL_HOTKEY_TELEPORTING = "<<1>>へ移動中。",
    SI_ESOQOL_HOTKEY_KEY_IN_USE = "ESO QoL：<<2>>は他のアクションで使用中のため、「<<1>>」は未割り当てのままです。操作 > キー割り当て > ESO QoL で設定してください。",

    -- Wheels
    SI_ESOQOL_WHEEL_EMPTY_COMPANIONS = "解放済みの仲間がいません。",
    SI_ESOQOL_WHEEL_EMPTY_ASSISTANTS = "解放済みのアシスタントがいません。",
    SI_ESOQOL_REASON_COMPANION_PENDING = "すでに仲間を召喚中です。",
    SI_ESOQOL_REASON_COMPANION_QUEST = "先にこの仲間の導入クエストを完了してください。",
    SI_ESOQOL_REASON_COOLDOWN = "クールダウン中：<<1>>",
    SI_ESOQOL_REASON_UNAVAILABLE = "現在は召喚できません。",
    SI_ESOQOL_CHAT_SUMMON = "<<1>>を召喚します。",
    SI_ESOQOL_CHAT_DISMISS = "<<1>>を解散します。",

    -- Pledges
    SI_ESOQOL_PLEDGE_MARKED = "アンドーンテッドの誓約：|cFFFFFF<<1>>|rをダンジョンファインダーでチェックしました。",
    SI_ESOQOL_PLEDGE_NOT_FOUND = "アンドーンテッドの誓約：ダンジョンファインダーに|cFFFFFF<<1>>|rの項目が見つかりません。",
    SI_ESOQOL_PLEDGE_READY = "アンドーンテッドの誓約：|cFFFFFF<<1>>|r完了、ダンジョンファインダーのチェックを外しました。クエストの依頼者のもとへ戻ってください。",

    -- Disassemble All (Giladil the Ragpicker)
    SI_ESOQOL_DISASSEMBLE_ALL = "すべて分解",
    SI_ESOQOL_DISASSEMBLE_STOP = "分解を停止",
    SI_ESOQOL_DISASSEMBLE_CONFIRM = "リストのアイテム<<1>>個を分解しますか？華麗特性のアイテム、ロック中のアイテム、アーモリービルドのアイテムはスキップされます。",
    SI_ESOQOL_DISASSEMBLE_NOTHING = "分解できるアイテムがありません。",
    SI_ESOQOL_DISASSEMBLE_DONE = "すべて分解：<<1>>個のアイテムを分解しました。",
    SI_ESOQOL_DISASSEMBLE_STOPPED = "すべて分解：<<1>>個分解した後に停止しました。",
    SI_ESOQOL_DISASSEMBLE_FAILED = "すべて分解：<<1>>個分解した後に停止しました（<<2>>）。",

    -- Settings
    SI_ESOQOL_SETTINGS_COMPANION_HEADER = "仲間ホイール",
    SI_ESOQOL_SETTINGS_ASSISTANT_HEADER = "アシスタントホイール",
    SI_ESOQOL_SETTINGS_WHEEL_DESC = "操作 > キー割り当て > ESO QoL で割り当てたキーを押し続けるとホイールが開きます。マウスを項目に合わせてキーを離すと召喚します。現在召喚できない項目はグレー表示になります。",
    SI_ESOQOL_SETTINGS_ENABLED = "有効",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE = "使用できない項目を隠す",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE_TT = "召喚できない項目をグレー表示ではなく非表示にします。",
    SI_ESOQOL_SETTINGS_TAP_ACTION = "キーを短く押して前回の項目を召喚/解散",
    SI_ESOQOL_SETTINGS_CHAT_MESSAGE = "召喚/解散時にチャットメッセージ",
    SI_ESOQOL_SETTINGS_TAP_ACTION_TT = "ホイールのキーを短く押すと、ホイールを開かずに前回使った項目を召喚します（すでに出ている場合は解散します）。",

    SI_ESOQOL_SETTINGS_PLEDGES_HEADER = "アンドーンテッドの誓約",
    SI_ESOQOL_SETTINGS_PLEDGES_DESC = "アンドーンテッドの誓約を受けると、そのダンジョンがダンジョンファインダーの特定ダンジョンリストでチェックされます。誓約を達成して報告するだけになったとき、または破棄したときにチェックは外されます。",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY = "チェックする難易度",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_AUTO = "自動（CP160からベテラン）",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_NORMAL = "ノーマル",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_VETERAN = "ベテラン",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC = "特定ダンジョンリストを開く",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC_TT = "誓約を受けている間、ダンジョンファインダーはランダムダンジョンではなく特定ダンジョンリストで開きます。",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT = "誓約ダンジョンを強調表示",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT_TT = "誓約を受けているダンジョンの名前を、ダンジョンファインダーのリストで水色で表示します。",
    SI_ESOQOL_SETTINGS_PLEDGES_NOTIFY = "チャット通知",

    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_HEADER = "ダンジョン実績",
    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_DESC = "ダンジョンファインダーの特定ダンジョンリストで、各ダンジョンの横のアイコンが獲得済みの実績を示します：ノーマルの行にはクリアのチェック、ベテランの行にはチェック、ハードモード、ノーデスのアイコン。未獲得の実績のアイコンは表示されません。",

    SI_ESOQOL_SETTINGS_INTRO_HEADER = "ゲーム起動",
    SI_ESOQOL_SETTINGS_INTRO_SKIP = "イントロ動画をスキップ",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_HEADER = "すべて分解",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_DESC = "くず拾いのギラディルの分解画面に「すべて分解」ボタンを追加します。リストに表示されているもの（現在のタブ、クラフトの種類フィルター、「銀行のアイテムを含む」）を、最大100個ずつ何も残らなくなるまで分解します。華麗、ロック中、アーモリーのアイテムはスキップされます。もう一度押すと停止します。",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CONFIRM = "確認を求める",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CHAT = "完了時にチャットメッセージ",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_HEADER = "確認ダイアログ",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT = "確認テキストを自動入力",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_TT = "確認のためにダイアログが入力を求める単語（アイテムの破壊時やロック中アイテムの改良時など）を、ゲームの言語で正確な大文字・小文字のまま入力します。確認ボタンはご自身で押してください。",
    SI_ESOQOL_SETTINGS_HOTKEYS_HEADER = "ホットキー",
    SI_ESOQOL_SETTINGS_HOTKEYS_DESC = "UIを再読み込み（初期設定F12）とメインの家へテレポート（初期設定Home）。キーは 操作 > キー割り当て > ESO QoL で変更できます。",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE = "家の外に到着",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE_TT = "家の中ではなく、屋外の入口にテレポートします。",
    SI_ESOQOL_SETTINGS_HOTKEYS_CHAT = "テレポート時にチャットメッセージ",

    SI_ESOQOL_SETTINGS_INTRO_SKIP_TT = "ゲーム起動時のロゴとイントロ動画をスキップします。次回のゲーム起動から有効になります。",

    -- Sell Ornate
    SI_ESOQOL_SELL_ORNATE_DONE = "華麗売却: アイテム<<1>>個を<<2>>で売却しました。",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_HEADER = "華麗アイテムの自動売却",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_DESC = "商人の店を開くと、所持品にある特性「華麗」のアイテムをすべて自動で売却します。ロック中、盗品、アーモリービルドのアイテムは除外されます。",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_UNCOLLECTED = "未収集のセット装備を残す",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_UNCOLLECTED_TT = "セットコレクションに未登録の華麗セットアイテムは売却しません。",
    SI_ESOQOL_SETTINGS_SELL_ORNATE_CHAT = "合計ゴールドをチャットに表示",
}

for stringId, text in pairs(strings) do
    SafeAddString(_G[stringId], text, 2)
end
