vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = "*", callback = function()
		vim.cmd([[
			hi link FloatBorder CmpPmenuBorder
			hi! link Pmenu CmpPmenu

			hi link TreesitterContext PmenuSel

			hi default link DashboardCenter DraculaYellow
			hi default link DashboardFooter DraculaPurple
			hi default link DapUIVariable Normal
			hi default link DapUIScope DraculaPurple
			hi default link DapUIType DraculaPurple
			hi default link DapUIDecoration DraculaCyan
			hi default link DapUIThread DraculaGreen
			hi default link DapUIStoppedThread DraculaCyan
			hi default link DapUIFrameName Normal
			hi default link DapUISource DraculaPurple
			hi default link DapUILineNumber DraculaCyan
			hi default link DapUIFloatBorder DraculaCyan
			hi default link DapUIWatchesHeader DraculaCyan
			hi default link DapUIWatchesEmpty DraculaOrange
			hi default link DapUIWatchesValue DraculaGreen
			hi default link DapUIWatchesError DraculaError
			hi default link DapUIWatchesFrame DraculaPurple
			hi default link DapUIBreakpointsPath DraculaCyan
			hi default link DapUIBreakpointsInfo DraculaGreen
			hi default link DapUIBreakpointsCurrentLine DraculaGreenBold
			hi default link DapUIBreakpointsLine DapUILineNumber

			hi link LspReferenceRead DraculaSelection
		    hi link LspReferenceWrite DraculaSelection
			hi link LspReferenceText DraculaSelection
	  ]])
	end,
})

-- colorscheme set to 0 to have transparent in transparent terminal
vim.g.dracula_colorterm = 0
vim.cmd('colorscheme dracula')
