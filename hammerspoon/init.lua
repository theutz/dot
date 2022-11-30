hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("ReloadConfiguration", { start = true })
spoon.SpoonInstall:andUse("EmmyLua")

require("utzwm")

hs.alert.show("Hammerspoon Loaded!")
