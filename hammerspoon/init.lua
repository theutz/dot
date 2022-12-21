hs.loadSpoon("SpoonInstall")
local log = require("log")

local mods = { "cmd", "ctrl", "alt" }

--spoon.SpoonInstall:andUse("EmmyLua")
spoon.SpoonInstall:andUse("ReloadConfiguration", {
  hotkeys = {
    reloadConfiguration = { mods, "r" }
  }
})

local hyper = require('hyper')
require("utzwm")

hyper.bindApp({}, "b", "Vivaldi")
hyper.bindApp({}, "e", "Emacs")
hyper.bindApp({}, "k", "kitty")
hyper.bindApp({}, "f", "Figma")
hyper.bindApp({}, "p", "Spotify")
hyper.bindApp({}, "s", "Slack")
hyper.bindApp({}, "t", "Telegram")
hyper.bindApp({}, "w", "WhatsApp")
hyper.bindApp({}, "m", "Messages")

hs.hotkey.bindSpec({ mods, "c" }, function()
  hs.task.new("/opt/homebrew/bin/fish", nil, { "-l", "-c", "doom +eveywhere" }):start()
end)

hs.alert.show("Hammerspoon Reloaded!")
