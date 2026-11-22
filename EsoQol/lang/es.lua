-- Español. Overrides the English strings from lang/en.lua; anything missing here stays English.
local strings =
{
    -- Keybindings
    SI_BINDING_NAME_ESOQOL_COMPANION_WHEEL = "Rueda de compañeros",
    SI_BINDING_NAME_ESOQOL_ASSISTANT_WHEEL = "Rueda de asistentes",
    SI_BINDING_NAME_ESOQOL_RELOAD_UI = "Recargar interfaz",
    SI_BINDING_NAME_ESOQOL_TELEPORT_HOME = "Teletransportarse a la residencia principal",

    -- Hotkeys
    SI_ESOQOL_HOTKEY_NO_PRIMARY_HOUSE = "No tienes una residencia principal establecida.",
    SI_ESOQOL_HOTKEY_IN_COMBAT = "No puedes viajar a casa durante el combate.",
    SI_ESOQOL_HOTKEY_TELEPORTING = "Viajando a <<1>>.",
    SI_ESOQOL_HOTKEY_KEY_IN_USE = "ESO QoL: <<2>> ya lo usa otra acción, así que «<<1>>» se ha quedado sin asignar. Asígnala en Controles > Asignación de teclas > ESO QoL.",

    -- Wheels
    SI_ESOQOL_WHEEL_EMPTY_COMPANIONS = "No tienes compañeros desbloqueados.",
    SI_ESOQOL_WHEEL_EMPTY_ASSISTANTS = "No tienes asistentes desbloqueados.",
    SI_ESOQOL_REASON_COMPANION_PENDING = "Ya se está invocando a un compañero.",
    SI_ESOQOL_REASON_COMPANION_QUEST = "Primero completa la misión de introducción de este compañero.",
    SI_ESOQOL_REASON_COOLDOWN = "En recarga: <<1>>",
    SI_ESOQOL_REASON_UNAVAILABLE = "No se puede invocar ahora mismo.",
    SI_ESOQOL_CHAT_SUMMON = "Invocando: <<1>>.",
    SI_ESOQOL_CHAT_DISMISS = "Retirando: <<1>>.",

    -- Pledges
    SI_ESOQOL_PLEDGE_MARKED = "Juramento de los Intrépidos: |cFFFFFF<<1>>|r marcada en el buscador de grupo.",
    SI_ESOQOL_PLEDGE_NOT_FOUND = "Juramento de los Intrépidos: no se ha encontrado ninguna entrada del buscador de grupo para |cFFFFFF<<1>>|r.",
    SI_ESOQOL_PLEDGE_READY = "Juramento de los Intrépidos: |cFFFFFF<<1>>|r completada, desmarcada en el buscador de grupo. Vuelve con quien te dio la misión.",

    -- Disassemble All (Giladil the Ragpicker)
    SI_ESOQOL_DISASSEMBLE_ALL = "Desmontar todo",
    SI_ESOQOL_DISASSEMBLE_STOP = "Dejar de desmontar",
    SI_ESOQOL_DISASSEMBLE_CONFIRM = "¿Desmontar los objetos de la lista (<<1>>)? Se omiten los objetos con el rasgo Ornamentado, los objetos bloqueados y los objetos de configuraciones del Arsenal.",
    SI_ESOQOL_DISASSEMBLE_NOTHING = "No hay nada que desmontar.",
    SI_ESOQOL_DISASSEMBLE_DONE = "Desmontar todo: <<1>> objetos desmontados.",
    SI_ESOQOL_DISASSEMBLE_STOPPED = "Desmontar todo: detenido tras <<1>> objetos.",
    SI_ESOQOL_DISASSEMBLE_FAILED = "Desmontar todo: detenido tras <<1>> objetos (<<2>>).",

    -- Settings
    SI_ESOQOL_SETTINGS_COMPANION_HEADER = "Rueda de compañeros",
    SI_ESOQOL_SETTINGS_ASSISTANT_HEADER = "Rueda de asistentes",
    SI_ESOQOL_SETTINGS_WHEEL_DESC = "Mantén pulsada la tecla asignada en Controles > Asignación de teclas > ESO QoL para abrir la rueda, mueve el ratón hasta una entrada y suelta la tecla para invocarla. Las entradas que no se pueden invocar ahora aparecen en gris.",
    SI_ESOQOL_SETTINGS_ENABLED = "Activado",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE = "Ocultar entradas no disponibles",
    SI_ESOQOL_SETTINGS_HIDE_UNAVAILABLE_TT = "Oculta las entradas que no se pueden invocar en lugar de mostrarlas en gris.",
    SI_ESOQOL_SETTINGS_TAP_ACTION = "Pulsación corta: invocar / retirar el último usado",
    SI_ESOQOL_SETTINGS_CHAT_MESSAGE = "Mensaje en el chat al invocar / retirar",
    SI_ESOQOL_SETTINGS_TAP_ACTION_TT = "Una pulsación corta de la tecla de la rueda invoca la última entrada usada (o la retira si ya está fuera) sin abrir la rueda.",

    SI_ESOQOL_SETTINGS_PLEDGES_HEADER = "Juramentos de los Intrépidos",
    SI_ESOQOL_SETTINGS_PLEDGES_DESC = "Cuando aceptas un juramento de los Intrépidos, su mazmorra se marca en la lista de mazmorras específicas del buscador de grupo. Se desmarca de nuevo cuando el juramento está hecho y solo queda entregarlo, o cuando se abandona.",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY = "Dificultad que marcar",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_AUTO = "Automática (veterano desde 160 CP)",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_NORMAL = "Normal",
    SI_ESOQOL_SETTINGS_PLEDGES_DIFFICULTY_VETERAN = "Veterano",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC = "Abrir la lista de mazmorras específicas",
    SI_ESOQOL_SETTINGS_PLEDGES_SPECIFIC_TT = "Mientras tengas un juramento, el buscador de grupo se abre en la lista de mazmorras específicas en lugar de en la mazmorra aleatoria.",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT = "Resaltar mazmorras de juramento",
    SI_ESOQOL_SETTINGS_PLEDGES_HIGHLIGHT_TT = "Muestra en azul claro, en la lista del buscador de grupo, los nombres de las mazmorras para las que tienes un juramento.",
    SI_ESOQOL_SETTINGS_PLEDGES_NOTIFY = "Aviso en el chat",

    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_HEADER = "Logros de mazmorra",
    SI_ESOQOL_SETTINGS_ACHIEVEMENTS_DESC = "Los iconos junto a cada mazmorra en la lista de mazmorras específicas del buscador de grupo muestran los logros que has conseguido: una marca en las filas normales por completarla en normal; una marca, un icono de modo difícil y otro de sin morir en las filas de veterano. Los iconos de logros no conseguidos se ocultan.",

    SI_ESOQOL_SETTINGS_INTRO_HEADER = "Inicio del juego",
    SI_ESOQOL_SETTINGS_INTRO_SKIP = "Saltar vídeos de introducción",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_HEADER = "Desmontar todo",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_DESC = "Añade un botón «Desmontar todo» a la pantalla de desmontaje de Giladil el Trapero. Desmonta todo lo que se muestra en la lista (pestaña actual, filtro de artesanía e «Incluir objetos del banco») en tandas de hasta 100 hasta que no quede nada. Se omiten los objetos ornamentados, bloqueados y del Arsenal. Púlsalo otra vez para detenerlo.",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CONFIRM = "Pedir confirmación",
    SI_ESOQOL_SETTINGS_DISASSEMBLE_CHAT = "Mensaje en el chat al terminar",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_HEADER = "Diálogos de confirmación",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT = "Rellenar automáticamente el texto de confirmación",
    SI_ESOQOL_SETTINGS_CONFIRM_TEXT_TT = "Escribe la palabra que los diálogos piden teclear para confirmar (p. ej. al destruir un objeto o al mejorar un objeto bloqueado), en el idioma del juego y con las mayúsculas exactas. El botón de confirmar lo sigues pulsando tú.",
    SI_ESOQOL_SETTINGS_HOTKEYS_HEADER = "Teclas rápidas",
    SI_ESOQOL_SETTINGS_HOTKEYS_DESC = "Recargar interfaz (F12 por defecto) y Teletransportarse a la residencia principal (Inicio por defecto). Cambia las teclas en Controles > Asignación de teclas > ESO QoL.",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE = "Llegar fuera de la casa",
    SI_ESOQOL_SETTINGS_HOTKEYS_OUTSIDE_TT = "Teletransporta a la entrada exterior de la casa en lugar de al interior.",
    SI_ESOQOL_SETTINGS_HOTKEYS_CHAT = "Mensaje en el chat al teletransportarse",

    SI_ESOQOL_SETTINGS_INTRO_SKIP_TT = "Salta el logotipo y los vídeos de introducción al iniciar el juego. Surte efecto a partir del próximo inicio.",
}

for stringId, text in pairs(strings) do
    SafeAddString(_G[stringId], text, 2)
end
