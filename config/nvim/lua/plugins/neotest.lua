local M = {
	module = "neotest",
	requires = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{ "nvim-neotest/neotest-plenary", module = "neotest-plenary" },
		{ "theutz/neotest-pest", module = "neotest-pest" },
		{ "haydenmeade/neotest-jest", module = "neotest-jest" },
	},
}

function M.init()
	require("which-key").register({
		["<leader>r"] = {
			name = "test",
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
			s = {
				function()
					require("neotest").run.run({ suite = true })
				end,
				"Run suite",
			},
		},
	})
end

function M.config()
	require("neotest").setup({
		adapters = {
			require("neotest-plenary"),
			require("neotest-pest")({}),
			require("neotest-jest"),
		},
	})
end

return M
