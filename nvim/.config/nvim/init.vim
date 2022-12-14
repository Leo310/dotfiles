function! MyHighlights() abort
	highlight link FloatBorder CmpPmenuBorder
	highlight! link Pmenu CmpPmenu

		hi link TreesitterContext PmenuSel

		hi link DashboardCenter DraculaYellow
		hi link DashboardFooter DraculaPurple

		" Dap highlights
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
endfunction
augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

" Rainbow Plugin
let g:rainbow_active = 0 "set to 0 if you want to enable it later via :RainbowToggle

autocmd BufWritePre *.go lua goimports(1000)

" Treesitter does everything now
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_types = 1
let g:go_rename_command = 'gopls'

augroup FileTypeSpecificAutocommands
    autocmd FileType javascript setlocal expandtab
    autocmd FileType typescript call SetTypescriptOptions()
    autocmd FileType java call SetJavaOptions()
		" Spellcheck
		autocmd FileType tex set spell spelllang=en_us,de_de
augroup END

function SetTypescriptOptions()
		setlocal expandtab
		setlocal shiftwidth=4
		setlocal softtabstop=4
endfunction

function SetJavaOptions()
		setlocal expandtab
		setlocal shiftwidth=4
		setlocal softtabstop=4
endfunction

let maplocalleader = " " " filetype specifc leader key
" Reload vims configuration file
nnoremap <Leader>r :source ~/.config/nvim/init.vim<CR>

" Vimtex settings
let g:vimtex_view_general_viewer = 'okular'

lua require('leo310')
