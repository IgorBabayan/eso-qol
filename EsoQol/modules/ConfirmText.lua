--[[
    Confirmation text auto-fill: dialogs that make you type a word to confirm (e.g. "DESTROY" /
    "УНИЧТОЖИТЬ" when destroying an item, "CONFIRM" when improving a locked item) get that word
    filled in, so the confirm button is ready right away.

    How it works:
    * The game marks these dialogs with editBox.matchingString in ESO_Dialogs. That string is built
      with GetString, so it is already in the client language with the exact case the game compares
      against (ZO_RequiredTextFields uses a case-sensitive ~=). Copying it is always correct, for every
      language and for any dialog the game adds later. Nothing is hard-coded.
    * Currently covered by the game: CONFIRM_DESTROY_ITEM_PROMPT, CONFIRM_DESTROY_ARMORY_ITEM_PROMPT,
      CONFIRM_IMPROVE_LOCKED_ITEM, CONFIRM_DECONSTRUCT_ARMORY_ITEM, CONFIRM_MULTI_DECONSTRUCT_ARMORY_ITEM,
      CONFIRM_CANCEL_RESEARCH, CONFIRM_ENCHANT_LOCKED_ITEM, CONFIRM_RETRAIT_LOCKED_ITEM.

    Performance notes:
    * One SecurePostHook on ZO_Dialogs_ShowDialog (no global override, no taint). It runs only when a
      dialog opens and leaves after a single table lookup for every dialog without a matchingString.
    * Queued dialogs are covered too: the queue shows them later through the same global function.
    * No events, no update loops.
]]

local addon = EsoQol

local ConfirmText =
{
    savedVarsKey = "confirmText",
}
addon.ConfirmText = ConfirmText

local function OnDialogShown(name)
    if not ConfirmText.savedVars.enabled then
        return
    end

    local dialogInfo = ESO_Dialogs[name]
    local editBoxInfo = type(dialogInfo) == "table" and dialogInfo.editBox
    local matchingString = editBoxInfo and editBoxInfo.matchingString
    if not matchingString or matchingString == "" then
        return
    end

    -- nil when the dialog was queued; the hook fires again when the queue shows it.
    local dialog = ZO_Dialogs_FindDialog(name)
    if not dialog or dialog.isGamepad or dialog.info ~= dialogInfo then
        return
    end

    local editControl = dialog:GetNamedChild("EditBox")
    if editControl then
        -- SetText fires OnTextChanged, so ZO_RequiredTextFields enables the confirm button.
        editControl:SetText(matchingString)
    end
end

function ConfirmText:SetEnabled(enabled)
    self.savedVars.enabled = enabled
end

function ConfirmText:Initialize(savedVars)
    self.savedVars = savedVars
    -- Hooked even while disabled (the handler returns at once), so enabling needs no reload.
    SecurePostHook("ZO_Dialogs_ShowDialog", OnDialogShown)
end

addon:RegisterModule(ConfirmText)
