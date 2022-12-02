local wf = hs.window.filter

local mods = { "ctrl", "alt", "cmd" }

spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", {
	hotkeys = {
		screen_left = { mods, "[" },
		screen_right = { mods, "]" },
	},
})

hs.grid.setGrid("6x4").setMargins("20x20")

hs.hotkey.bind(mods, "/", function()
	hs.grid.show()
end)

hs.hotkey.bind(mods, "h", function()
	hs.grid.set(hs.window.frontmostWindow(), "0,0 3x4")
end)

hs.hotkey.bind(mods, "l", function()
	hs.grid.set(hs.window.frontmostWindow(), "3,0 3x4")
end)

hs.hotkey.bind(mods, "k", function()
	hs.grid.set(hs.window.frontmostWindow(), "0,0 6x2")
end)

hs.hotkey.bind(mods, "j", function()
	hs.grid.set(hs.window.frontmostWindow(), "0,3 6x2")
end)

hs.hotkey.bind(mods, "return", function()
	hs.grid.maximizeWindow(hs.window.frontmostWindow())
end)

hs.hotkey.bind(mods, "space", function()
	hs.grid.set(hs.window.frontmostWindow(), "1,0 4x4")
end)

utzwmwatcher = wf.new(true)

utzwmwatcher:subscribe(wf.windowFocused, function(win)
	hs.grid.snap(win)
end)
