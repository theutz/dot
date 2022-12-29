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

hyper.bindApp({}, "1", "Emacs") -- Default Editor
hyper.bindApp({}, "2", "Vivaldi") -- Default Browser
hyper.bindApp({}, "3", "kitty") -- Default Terminal
hyper.bindApp({}, "4", "Spotify") -- Default Music Player
hyper.bindApp({}, "5", "Surfshark") -- Default VPN

hyper.bindApp({}, "c", "Google Chrome")
hyper.bindApp({}, "d", "Dash")
hyper.bindApp({}, "e", "Emacs")
hyper.bindApp({}, "f", "Figma")
hyper.bindApp({}, "h", "Hammerspoon")
hyper.bindApp({}, "k", "kitty")
hyper.bindApp({}, "m", "Messages")
hyper.bindApp({}, "p", "Spotify")
hyper.bindApp({}, "r", "Ray")
hyper.bindApp({}, "s", "Slack")
hyper.bindApp({}, "t", "Telegram")
hyper.bindApp({}, "u", "Surfshark")
hyper.bindApp({}, "v", "Vivaldi")
hyper.bindApp({}, "w", "WhatsApp")

local function logTaskErr(taskName)
  return function (exitCode, stdOut, stdErr)
    log.f("Running %s", taskName)
    log.d(stdOut)

    if exitCode > 0 then
      log.ef("%s: %d %s", taskName, exitCode, stdErr)
    end
  end
end

local function runInShell(command)
  return function ()
    hs.task.new(
      "/opt/homebrew/bin/fish",
      logTaskErr(command),
      { "-l", "-c", command }
    ):start()
  end
end

hs.hotkey.bindSpec({ mods, "c" }, runInShell("doom +everywhere"))
hs.hotkey.bindSpec({ mods, "x" }, runInShell("emacsclient -ne '(utz/make-capture-frame)'"))

hs.alert.show("Hammerspoon Reloaded!")
