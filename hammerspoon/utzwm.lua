local wf = hs.window.filter
local grid = hs.grid
local hk = hs.hotkey

local mods = { "ctrl", "alt", "cmd" }

grid.setGrid("6x4").setMargins("20x20")

hk.bindSpec({ mods, "return" }, function()
	grid.show()
end)

wf.new(true):subscribe(wf.windowFocused, function(win)
	grid.snap(win)
end)
