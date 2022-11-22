local M = {
	event = "BufReadPost",
}

function M.config()
	local scrollbar = require("scrollbar")

	-- PERF: throttle scrollbar refresh
	-- Disable, throttle, since it was caused by comment TS
	-- local render = scrollbar.render
	-- scrollbar.render = require("util").throttle(300, render)

	local colors = require("catppuccin.palettes").get_palette("macchiato")
	scrollbar.setup({
		handle = {
			color = colors.bg_highlight,
		},
		excluded_filetypes = {
			"prompt",
			"TelescopePrompt",
			"noice",
			"notify",
		},
		marks = {
			Search = { color = colors.blue },
			Error = { color = colors.red },
			Warn = { color = colors.yellow },
			Info = { color = colors.sky },
			Hint = { color = colors.surface2 },
			Misc = { color = colors.lavender },
		},
	})
end

return M
