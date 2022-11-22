local packer = require("util.packer")

local config = {
	profile = {
		enable = true,
		threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	},
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
	opt_default = true,
	auto_reload_compiled = false,
	-- list of plugins that should be taken from ~/Code
	-- this is NOT packer functionality!
	local_plugins = {
		-- folke = true,
		-- ["ggandor/flit.nvim"] = true,
		-- ["ggandor/leap.nvim"] = true,
		-- ["null-ls.nvim"] = true,
		-- ["nvim-lspconfig"] = true,
		-- ["nvim-notify"] = true,
		-- ["yanky.nvim"] = true,
		-- ["nui.nvim"] = true,
		-- ["nvim-treesitter/nvim-treesitter"] = true,
	},
}

local function plugins(use, plugin)
	-- Packer can manage itself as an optional plugin
	use({ "wbthomason/packer.nvim" })
	plugin("folke/noice.nvim")

	use({
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		module = "inc_rename",
		config = function()
			require("inc_rename").setup()
		end,
	})

	use({ "stevearc/dressing.nvim", event = "User PackerDefered" })

	plugin("anuvyklack/windows.nvim")

	plugin("rcarriga/nvim-notify")

	use({
		"catppuccin/nvim",
		event = "User PackerDefered",
		as = "catppuccin",
		module = "catppuccin",
		config = function()
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	})

	use({
		"folke/persistence.nvim",
		event = "BufReadPre",
		module = "persistence",
		config = function()
			require("persistence").setup({
				options = { "buffers", "curdir", "tabpages", "winsize", "help" },
			})
		end,
	})

	use({
		"folke/which-key.nvim",
		module = "which-key",
	})

	plugin("nvim-neo-tree/neo-tree.nvim")

	use({
		"MunifTanjim/nui.nvim",
		module = "nui",
	})

	use({ "nvim-lua/plenary.nvim", module = "plenary" })

	use({
		"kyazdani42/nvim-web-devicons",
		module = "nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	})

	plugin("echasnovski/mini.nvim")

	use({
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		config = function()
			require("treesitter-context").setup()
		end,
	})

	plugin("nvim-treesitter/nvim-treesitter")

	plugin("williamboman/mason.nvim")
	use({
		"williamboman/mason-lspconfig.nvim",
		module = "mason-lspconfig",
	})
	use({ "folke/neodev.nvim", module = "neodev" })
	use({
		"folke/neoconf.nvim",
		module = "neoconf",
		cmd = "Neoconf",
	})
	use({ "neovim/nvim-lspconfig", plugin = "lsp" })

	plugin("akinsho/nvim-bufferline.lua")

	use({ "b0o/SchemaStore.nvim", module = "schemastore" })

	plugin("hrsh7th/nvim-cmp")

	use({
		"SmiteshP/nvim-navic",
		module = "nvim-navic",
		config = function()
			vim.g.navic_silence = true
			require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
		end,
	})

	use({ "jose-elias-alvarez/typescript.nvim", module = "typescript" })

	plugin("jose-elias-alvarez/null-ls.nvim")

	plugin("lewis6991/gitsigns.nvim")

	plugin("nvim-telescope/telescope.nvim")

	use({
		"folke/trouble.nvim",
		event = "BufReadPre",
		module = "trouble",
		cmd = { "TroubleToggle", "Trouble" },
		config = function()
			require("trouble").setup({
				auto_open = false,
				use_diagnostic_signs = true, -- en
			})
		end,
	})
	plugin("karb94/neoscroll.nvim")

	use({ "folke/twilight.nvim", module = "twilight" })
	use({
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			require("zen-mode").setup({
				plugins = { gitsigns = true, tmux = true, kitty = { enabled = false, font = "+2" } },
			})
		end,
	})

	plugin("folke/todo-comments.nvim")

	plugin("sindrets/diffview.nvim")

	plugin("L3MON4D3/LuaSnip")

	use({
		"danymat/neogen",
		module = "neogen",
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
	})

	plugin("petertriho/nvim-scrollbar")

	plugin("toppair/peek.nvim")

	use({
		"m-demare/hlargs.nvim",
		event = "User PackerDefered",
		config = function()
			require("hlargs").setup({
				excluded_argnames = {
					usages = {
						lua = { "self", "use" },
					},
				},
			})
		end,
	})

	use({
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
		config = function()
			require("symbols-outline").setup()
		end,
		setup = function()
			vim.keymap.set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
		end,
	})

	plugin("b0o/incline.nvim")

	plugin("gbprod/yanky.nvim")

	use({
		"folke/drop.nvim",
		event = "VimEnter",
		config = function()
			math.randomseed(os.time())
			local theme = ({ "stars", "snow" })[math.random(1, 2)]
			require("drop").setup({ theme = theme })
		end,
	})

	use({ "nvim-treesitter/playground", cmd = { "TSHighlightCapturesUnderCursor", "TSPlaygroundToggle" } })

	use({
		"norcalli/nvim-terminal.lua",
		ft = "terminal",
		config = function()
			require("terminal").setup()
		end,
	})

	use({
		"windwp/nvim-spectre",
		module = "spectre",
	})

	use({
		"alker0/chezmoi.vim",
		opt = false,
	})

	plugin("lukas-reineke/indent-blankline.nvim")

	plugin("akinsho/nvim-toggleterm.lua")
end
return packer.setup(config, plugins)
