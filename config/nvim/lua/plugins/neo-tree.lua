return {
	requires = {
		{

			"s1n7ax/nvim-window-picker",
			config = function()
				require("window-picker").setup()
			end,
		},
	},
	cmd = "Neotree",
	config = function()
		vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

		require("neo-tree").setup({ filesystem = { follow_current_file = true } })
	end,
}
