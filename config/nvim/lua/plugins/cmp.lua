local M = {
	event = "InsertEnter",
	module = "cmp",
	requires = {
		{ "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-cmdline",
		"dmitmel/cmp-cmdline-history",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
	},
}

function M.config()
	vim.o.completeopt = "menuone,noselect"

	-- Setup nvim-cmp.
	local cmp = require("cmp")

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-e>"] = cmp.mapping.abort(),
			["<c-y>"] = cmp.mapping(
				cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
				{ "i", "c" }
			),
			["<M-y>"] = cmp.mapping(
				cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
				{ "i", "c" }
			),

			["<c-space>"] = cmp.mapping({
				i = cmp.mapping.complete(),
				c = function(
					_ --[[fallback]]
				)
					if cmp.visible() then
						if not cmp.confirm({ select = true }) then
							return
						end
					else
						cmp.complete()
					end
				end,
			}),

			-- ["<tab>"] = false,
			["<tab>"] = cmp.config.disable,
		},
		sources = cmp.config.sources({
			-- { name = "nvim_lua" },
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			-- { name = "copilot" },
		}, {
			{ name = "path" },
			{ name = "buffer", keyword_length = 5 },
		}, {
			{ name = "emoji" },
			{ name = "neorg" },
			-- { name = "gh_issues" },
		}),
		-- sources = cmp.config.sources({
		-- 	{ name = "nvim_lsp" },
		-- 	{ name = "luasnip" },
		-- 	{ name = "buffer" },
		-- 	{ name = "path" },
		-- 	{ name = "emoji" },
		-- 	{ name = "neorg" },
		-- }),
		formatting = {
			format = require("plugins.lsp.kind").cmp_format(),
		},
		-- documentation = {
		--   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		--   winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
		-- },
		experimental = {
			native_menu = false,
			ghost_text = {
				hl_group = "LspCodeLens",
			},
		},
		-- sorting = {
		--   comparators = {
		--     cmp.config.compare.sort_text,
		--     cmp.config.compare.offset,
		--     -- cmp.config.compare.exact,
		--     cmp.config.compare.score,
		--     -- cmp.config.compare.kind,
		--     -- cmp.config.compare.length,
		--     cmp.config.compare.order,
		--   },
		-- },
	})

	-- cmp.setup.cmdline(":", {
	--   mapping = cmp.mapping.preset.cmdline(),
	--   sources = cmp.config.sources({
	--     -- { name = "noice_popupmenu" },
	--     { name = "path" },
	--     { name = "cmdline" },
	--     -- { name = "cmdline_history" },
	--   }),
	-- })
end

return M
