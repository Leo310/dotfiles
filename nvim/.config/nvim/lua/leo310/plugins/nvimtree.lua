return {
	'nvim-tree/nvim-tree.lua',
	dependecies = {
		'nvim-tree/nvim-web-devicons',
	},
	init = function()
		-- Keymaps
		vim.keymap.set("n", "<leader>v", ":NvimTreeFindFile<cr>", { desc = 'Find File in Tree' })
		vim.keymap.set("n", "<C-s>", ":NvimTreeToggle<cr>", { desc = 'Toggle Tree' })

		-- disable netrw at the very start of your init.lua (strongly advised)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

	end,
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			actions = {
				open_file = {
					quit_on_open = true,
				}
			}
		})
	end
}
