local log = require("log")
local wf = hs.window.filter

local mods = { "ctrl", "alt", "cmd" }

spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", {
	hotkeys = {
		screen_left = { mods, "[" },
		screen_right = { mods, "]" },
	},
})

local gridSize = hs.geometry.size(12, 8) or {}
local gridMargin = hs.geometry.size(16, 16) or {}

hs.grid.setGrid(gridSize).setMargins(gridMargin)

hs.hotkey.bind(mods, "/", function()
	hs.grid.show()
end)

hs.hotkey.bind(mods, "h", function()
	---@type hs.window
	local win = hs.window.frontmostWindow()
	local current = hs.grid.get(win)

	local initial = hs.geometry.new("0,0 6x8")

	---@type table
	local big = initial:copy()
	big.w = big.w + 2

	---@type table
	local small = initial:copy()
	small.w = small.w - 2

	local target = initial

	if initial == current then
		target = big
	elseif current == big then
		target = small
	end

	hs.grid.set(win, target)
end)

hs.hotkey.bind(mods, "l", function()
	local win = hs.window.frontmostWindow()
	local current = hs.grid.get(win)

	local initial = hs.geometry.new("6,0 6x8")

	---@type table
	local big = initial:copy()
	big.w = big.w + 2
	big.x = big.x - 2

	---@type table
	local small = initial:copy()
	small.w = small.w - 2
	small.x = small.x + 2

	local target = initial

	if current == initial then
		target = big
	elseif current == big then
		target = small
	end

	hs.grid.set(win, target)
end)

hs.hotkey.bind(mods, "k", function()
	local win = hs.window.frontmostWindow()
	local current = hs.grid.get(win)

	local initial = hs.geometry.new("0,0 12x4")

	---@type table
	local right_corner = initial:copy()
	right_corner.w = 6
	right_corner.x = 6

	---@type table
	local left_corner = initial:copy()
	left_corner.w = 6
	left_corner.x = 0

	local target = initial

	if current == initial then
		target = left_corner
	elseif current == left_corner then
		target = right_corner
	end

	hs.grid.set(win, target)
end)

hs.hotkey.bind(mods, "j", function()
	local win = hs.window.frontmostWindow()
	local current = hs.grid.get(win)

	local initial = hs.geometry.new("0,4 12x4")

	---@type table
	local right_corner = initial:copy()
	right_corner.w = 6
	right_corner.x = 6

	---@type table
	local left_corner = initial:copy()
	left_corner.w = 6
	left_corner.x = 0

	local target = initial

	if current == initial then
		target = left_corner
	elseif current == left_corner then
		target = right_corner
	end

	hs.grid.set(win, target)
end)

hs.hotkey.bind(mods, "return", function()
	local win = hs.window.frontmostWindow()
	local current = hs.grid.get(win)

	local initial = hs.geometry.new({ 0, 0, gridSize.w, gridSize.h })

	---@type table
	local two_thirds = initial:copy()
	two_thirds.w = two_thirds.w - 4
	two_thirds.x = two_thirds.x + 2

	---@type table
	local half = initial:copy()
	half.w = half.w - 6
	half.x = half.x + 3

	local target = initial

	if current == initial then
		target = two_thirds
	elseif current == two_thirds then
		target = half
	end

	hs.grid.set(win, target)
end)

hs.hotkey.bind(mods, "space", function()
	local win = hs.window.frontmostWindow()
	---@type table
	local frame = win:centerOnScreen():frame()
	frame.y = frame.y + gridMargin.h - 3 -- not sure why we need this 3, but we do
	win:move(frame)
end)

WatchMessagingApps = wf.new({ "Messages", "Telegram", "WhatsApp", "Slack" })

WatchMessagingApps:subscribe({ wf.windowVisible, wf.windowFocused }, function(win, name)
	hs.grid.set(win, { 3, 1, 6, 6 }, hs.screen.primaryScreen())
end)

WatchMessagingApps:subscribe(wf.windowUnfocused, function(win, name)
	local screen = hs.screen.primaryScreen()
	if win:screen() == screen then
		screen = screen:next()
	end
	hs.grid.set(win, { 0, 0, 12, 8 }, screen)
end)
