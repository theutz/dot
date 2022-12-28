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

hyper.bindApp({}, "1", "Vivaldi")
hyper.bindApp({}, "2", "Emacs")
hyper.bindApp({}, "3", "kitty")
hyper.bindApp({}, "4", "Spotify")
hyper.bindApp({}, "5", "Surfshark")

hyper.bindApp({}, "c", "Google Chrome")
hyper.bindApp({}, "f", "Figma")
hyper.bindApp({}, "m", "Messages")
hyper.bindApp({}, "s", "Slack")
hyper.bindApp({}, "t", "Telegram")
hyper.bindApp({}, "w", "WhatsApp")

hs.hotkey.bindSpec({ mods, "c" }, function()
  hs.task.new("/opt/homebrew/bin/fish", function(exitCode, stdErr)
    if exitCode > 0 then
      print('Emacs Everywhere: ', exitCode, stdErr)
    end
  end, { "-l", "-c", 'doom +everywhere' }):start()
end)

hs.alert.show("Hammerspoon Reloaded!")
