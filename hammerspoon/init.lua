hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("ReloadConfiguration", { start = true })
spoon.SpoonInstall:andUse("EmmyLua")

hs.alert.show("Hammerspoon Loaded!")
