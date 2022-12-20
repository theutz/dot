local log = require("log")

hs.loadSpoon("SpoonInstall")

--spoon.SpoonInstall:andUse("EmmyLua")
spoon.SpoonInstall:andUse("ReloadConfiguration", { start = true })

local hyper = require('hyper')
require("utzwm")
local mods = { "cmd", "ctrl", "alt" }

hyper.bindApp({}, "b", "Vivaldi")
hyper.bindApp({}, "e", "Emacs")
hyper.bindApp({}, "k", "kitty")
hyper.bindApp({}, "f", "Figma")
hyper.bindApp({}, "p", "Spotify")
hyper.bindApp({}, "l", "Slack")
hyper.bindApp({}, "t", "Telegram")
hyper.bindApp({}, "w", "WhatsApp")
hyper.bindApp({}, "m", "Messages")

hs.hotkey.bindSpec({ mods, "c" }, function()
  hs.task.new("/opt/homebrew/bin/fish", nil, { "-l", "-c", "doom +eveywhere" }):start()
end)

hs.alert.show("Hammerspoon Reloaded!")
