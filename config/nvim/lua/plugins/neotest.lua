local M = {
	event = "User PackerDefered",
	module = "neotest",
	requires = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{ "nvim-neotest/neotest-plenary", module = "neotest-plenary" },
		{ "theutz/neotest-pest", module = "neotest-pest" },
		{ "haydenmeade/neotest-jest", module = "neotest-jest" },
	},
}

function M.config()
	require("neotest").setup({
		log_level = vim.log.levels.DEBUG,
		summary = {
			enabled = true,
			expand_errors = true,
		},
		diagnostic = {
			enabled = true,
		},
		output = {
			enabled = true,
			open_on_run = true,
		},
		adapters = {
			require("neotest-pest"),
			require("neotest-plenary"),
			require("neotest-jest"),
		},
	})

	require("which-key").register({
		["<leader>r"] = {
			name = "test",
			s = {
				function()
					require("neotest").summary.toggle()
				end,
				"Show summary",
			},
			r = {
				function()
					require("neotest").run.run()
				end,
				"Run nearest",
			},
			f = {
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				"Run file",
			},
			d = {
				function()
					require("neotest").run.run(vim.fn.expand("%:p:h"))
				end,
				"Run directory",
			},
			a = {
				function()
					require("neotest").run.run({ suite = true })
				end,
				"Run suite",
			},
			o = {
				function()
					require("neotest").output.open({ enter = true, short = true })
				end,
				"Show short output",
			},
			O = {
				function()
					require("neotest").output.open({ enter = true, short = false })
				end,
				"Show full output",
			},
		},
	})
end

return M
