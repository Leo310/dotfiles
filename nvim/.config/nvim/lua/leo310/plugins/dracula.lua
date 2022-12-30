return {
	'dracula/vim',
	name = 'dracula',
	lazy = false,
	priority = 999,
	config = function()
		-- colorscheme set to 0 to have transparent in transparent terminal
		vim.g.dracula_colorterm = 0
		vim.cmd('colorscheme dracula')
	end
}
