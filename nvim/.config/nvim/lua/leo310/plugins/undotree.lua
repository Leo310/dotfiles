return {
	'mbbill/undotree',
	init = function()
		vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = 'Better undo' })
	end
}
