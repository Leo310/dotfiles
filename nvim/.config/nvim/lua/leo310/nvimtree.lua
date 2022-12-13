-- Keymaps
vim.keymap.set("n", "<leader>v", ":NvimTreeFind<cr>", { desc = 'Find File in Tree' })
vim.keymap.set("n", "<C-s>", ":NvimTreeToggle<cr>", { desc = 'Toggle Tree' })

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	actions = {
		open_file = {
			quit_on_open = true,
		}
	}
})
