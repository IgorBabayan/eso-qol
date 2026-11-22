-- Français. Overrides the English strings from lang/en.lua; anything missing here stays English.
local strings =
{
    -- Keybindings
    SI_BINDING_NAME_ESOQOL_COMPANION_WHEEL = "Roue des compagnons",
    SI_BINDING_NAME_ESOQOL_ASSISTANT_WHEEL = "Roue des assistants",
    SI_BINDING_NAME_ESOQOL_RELOAD_UI = "Recharger l'interface",
    SI_BINDING_NAME_ESOQOL_TELEPORT_HOME = "Se téléporter à la résidence principale",

    -- Hotkeys
    SI_ESOQOL_HOTKEY_NO_PRIMARY_HOUSE = "Vous n'avez pas défini de résidence principale.",
    SI_ESOQOL_HOTKEY_IN_COMBAT = "Vous ne pouvez pas rentrer chez vous en combat.",
    SI_ESOQOL_HOTKEY_TELEPORTING = "Voyage vers <<1>>.",
    SI_ESOQOL_HOTKEY_KEY_IN_USE = "ESO QoL : <<2>> est déjà utilisé par une autre action, « <<1>> » n'a donc pas été assigné. Définissez la touche dans Commandes > Raccourcis clavier > ESO QoL.",

    -- Wheels
    SI_ESOQOL_WHEEL_EMPTY_COMPANIONS = "Vous n'avez débloqué aucun compagnon.",
    SI_ESOQOL_WHEEL_EMPTY_ASSISTANTS = "Vous n'avez débloqué aucun assistant.",
    SI_ESOQOL_REASON_COMPANION_PENDING = "Un compagnon est déjà en cours d'invocation.",
    SI_ESOQOL_REASON_COMPANION_QUEST = "Terminez d'abord la quête d'introduction de ce compagnon.",
    SI_ESOQOL_REASON_COOLDOWN = "Temps de recharge : <<1>>",
    SI_ESOQOL_REASON_UNAVAILABLE = "Invocation impossible pour le moment.",
    SI_ESOQOL_CHAT_SUMMON = "Invocation : <<1>>.",
    SI_ESOQOL_CHAT_DISMISS = "Renvoi : <<1>>.",

    -- Pledges
    SI_ESOQOL_PLEDGE_MARKED = "Engagement des Indomptables : |cFFFFFF<<1>>|r coché dans la recherche de groupe.",
    SI_ESOQOL_PLEDGE_NOT_FOUND = "Engagement des Indomptables : aucune entrée trouvée dans la recherche de groupe pour |cFFFFFF<<1>>|r.",
    SI_ESOQOL_PLEDGE_READY = "Engagement des Indomptables : |cFFFFFF<<1>>|r terminé, décoché dans la recherche de groupe. Retournez voir le donneur de quête.",

    -- Disassemble All (Giladil the Ragpicker)
    SI_ESOQOL_DISASSEMBLE_ALL = "Tout désassembler",
    SI_ESOQOL_DISASSEMBLE_STOP = "Arrêter le désassemblage",
    SI_ESOQOL_DISASSEMBLE_CONFIRM = "Désassembler les objets de la liste (<<1>>) ? Les objets avec le trait Orné, les objets verrouillés et les objets des configurations de l'Arsenal sont ignorés.",
    SI_ESOQOL_DISASSEMBLE_NOTHING = "Rien à désassembler.",
    SI_ESOQOL_DISASSEMBLE_DONE = "Tout désassembler : <<1>> objets désassemblés.",
    SI_ESOQOL_DISASSEMBLE_STOPPED = "Tout désassembler : arrêté après <<1>> objets.",
    SI_ESOQOL_DISASSEMBLE_FAILED = "Tout désassembler : arrêté après <<1>> objets (<<2>>).",

    -- Settings
    SI_ESOQOL_SETTINGS_COMPANION_HEADER = "Roue des compagnons",
    SI_ESOQOL_SETTINGS_ASSISTANT_HEADER = "Roue des assistants",
    SI_ESOQOL_SETTINGS_WHEEL_DESC = "Maintenez la touche définie dans Commandes > Raccourcis clavier > ESO QoL pour ouvrir la roue, placez la souris sur une entrée et relâchez la touche pour l'invoquer. Les entrées qui ne peuvent pas être invoquées pour le moment sont grisées.",
    SI_ESOQOL_SETTINGS_ENABLED = "Activé",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE = "Masquer les entrées indisponibles",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE_TT = "Masque les entrées qui ne peuvent pas être invoquées au lieu de les afficher grisées.",
    SI_ESOQOL_SETTINGS_TAP_ACTION = "Appui bref : invoquer / renvoyer le dernier utilisé",
    SI_ESOQOL_SETTINGS_CHAT_MESSAGE = "Message de discussion à l'invocation / au renvoi",
    SI_ESOQOL_SETTINGS_TAP_ACTION_TT = "Un appui bref sur la touche de la roue invoque l'entrée utilisée en dernier (ou la renvoie si elle est déjà présente), sans ouvrir la roue.",

    SI_ESOQOL_SETTINGS_PLEDGES_HEADER = "Engagements des Indomptables",
    SI_ESOQOL_SETTINGS_PLEDGES_DESC = "Lorsque vous acceptez un engagement des Indomptables, son donjon est coché dans la liste des donjons spécifiques de la recherche de groupe. Il est décoché une fois l'engagement accompli et qu'il ne reste plus qu'à le rendre, ou s'il est abandonné.",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY = "Difficulté à cocher",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_AUTO = "Auto (vétéran à partir de 160 CP)",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_NORMAL = "Normal",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_VETERAN = "Vétéran",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC = "Ouvrir la liste des donjons spécifiques",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC_TT = "Tant que vous avez un engagement, la recherche de groupe s'ouvre sur la liste des donjons spécifiques au lieu du donjon aléatoire.",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT = "Mettre en évidence les donjons d'engagement",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT_TT = "Affiche en bleu clair, dans la liste de la recherche de groupe, le nom des donjons pour lesquels vous avez un engagement.",
    SI_ESOQOL_SETTINGS_PLEDGES_NOTIFY = "Notification dans la discussion",

    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_HEADER = "Succès de donjon",
    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_DESC = "Des icônes à côté de chaque donjon de la liste des donjons spécifiques de la recherche de groupe indiquent les succès obtenus : une coche sur les lignes normales pour la réussite en normal ; une coche, une icône de mode difficile et une icône sans mort sur les lignes vétéran. Les icônes des succès non obtenus sont masquées.",

    SI_ESOQOL_SETTINGS_INTRO_HEADER = "Lancement du jeu",
    SI_ESOQOL_SETTINGS_INTRO_SKIP = "Passer les vidéos d'introduction",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_HEADER = "Tout désassembler",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_DESC = "Ajoute un bouton « Tout désassembler » à l'écran de déconstruction de Giladil le Chiffonnier. Il déconstruit tout ce qui est affiché dans la liste (onglet actuel, filtre d'artisanat et « Inclure les objets en banque ») par lots de 100 objets maximum, jusqu'à ce qu'il ne reste plus rien. Les objets ornés, verrouillés et de l'Arsenal sont ignorés. Appuyez de nouveau pour arrêter.",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CONFIRM = "Demander une confirmation",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CHAT = "Message de discussion une fois terminé",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_HEADER = "Fenêtres de confirmation",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT = "Remplir automatiquement le texte de confirmation",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_TT = "Saisit le mot que les fenêtres demandent de taper pour confirmer (par ex. lors de la destruction d'un objet ou de l'amélioration d'un objet verrouillé), dans la langue du jeu et avec la casse exacte. Vous appuyez toujours vous-même sur le bouton de confirmation.",
    SI_ESOQOL_SETTINGS_HOTKEYS_HEADER = "Raccourcis",
    SI_ESOQOL_SETTINGS_HOTKEYS_DESC = "Recharger l'interface (F12 par défaut) et Se téléporter à la résidence principale (Origine par défaut). Modifiez les touches dans Commandes > Raccourcis clavier > ESO QoL.",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE = "Arriver devant la maison",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE_TT = "Téléporte à l'entrée extérieure de la maison plutôt qu'à l'intérieur.",
    SI_ESOQOL_SETTINGS_HOTKEYS_CHAT = "Message de discussion lors de la téléportation",

    SI_ESOQOL_SETTINGS_INTRO_SKIP_TT = "Passe le logo et les vidéos d'introduction au lancement du jeu. Prend effet au prochain lancement.",
}

for stringId, text in pairs(strings) do
    SafeAddString(_G[stringId], text, 2)
end
