return {
	'tpope/vim-fugitive',
	init = function()
		vim.keymap.set("n", "<leader>gs", ":G<CR>", { desc = 'Opens fugitiv' })
		vim.keymap.set("n", "<leader>gj", ":diffget //3<CR>", { desc = 'Take right changes' })
		vim.keymap.set("n", "<leader>gf", ":diffget //2<CR>", { desc = 'Take left changes' })
	end
}
