local M = {
	event = "BufReadPre",
}

function M.config()
	local colors = require("catppuccin.palettes").get_palette("macchiato")

	require("incline").setup({
		highlight = {
			groups = {
				InclineNormal = {
					guibg = colors.sapphire,
					guifg = colors.crust,
					-- gui = "bold",
				},
				InclineNormalNC = {
					guibg = colors.base,
					guifg = colors.sapphire,
				},
			},
		},
		window = {
			margin = {
				vertical = 1,
				horizontal = 1,
			},
		},
		hide = {
			cursorline = "focused_win",
		},
		render = function(props)
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			local icon, color = require("nvim-web-devicons").get_icon_color(filename)
			return {
				{ icon, guifg = color },
				{ " " },
				{ filename },
			}
		end,
	})
end

return M
