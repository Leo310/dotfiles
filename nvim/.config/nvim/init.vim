lua require('leo310')

function! MyHighlights() abort
	highlight link FloatBorder CmpPmenuBorder
	highlight! link Pmenu CmpPmenu

		hi link TreesitterContext PmenuSel

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


let g:dashboard_default_executive ='telescope'
let g:dashboard_custom_footer = ["To the stars!!!"]
let g:dashboard_custom_section = {
	  \ 'a': {
      \ 'description': ['  Find File          '],
      \ 'command': 'Telescope find_files'},
	  \ 'b': {
      \ 'description': ['  New File           '],
      \ 'command': ':ene!'},
	  \ 'c': {
      \ 'description': ['  Recent Projects    '],
      \ 'command': 'Telescope project'},
	  \ 'd': {
      \ 'description': ['  Recently Used Files'],
      \ 'command': 'Telescope oldfiles'},
  \ }

" let g:dashboard_preview_command = 'cat'
" let g:dashboard_preview_pipeline = 'lolcat'
" let g:dashboard_preview_file = '~/.config/nvim/neovim.cat'
" let g:dashboard_preview_file_height = 12
" let g:dashboard_preview_file_width = 80
let g:seed = srand()
let headfiles = split(system("ls ~/.config/nvim/head*" ), "\n")
let randomHead = headfiles[rand(g:seed)%len(headfiles)]
let speed = "1.0"
" slow files
if stridx(randomHead, "head1") != -1
	let speed = "0.4"
elseif stridx(randomHead, "head3") != -1
	let speed = "0.6"
endif
" let randomHead = "~/.config/nvim/head5.gif"
let g:dashboard_preview_command = 'chafa -c full --fg-only --speed '. speed . ' --symbols braille'
let g:dashboard_preview_file = randomHead
let g:dashboard_preview_file_height = 20
let g:dashboard_preview_file_width = 40

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

" debugger
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F6> <Cmd>lua require'dap'.terminate()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>                                                       
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>                                                       
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>                                                        
nnoremap <silent> <leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>d <Cmd>lua require'dap'.repl.toggle()<CR>
nnoremap <silent> <leader>cl <Cmd>lua require'dap'.clear_breakpoints()<CR>
nnoremap <silent> <leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>        
nnoremap <silent> <leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr <Cmd>lua require'dap'.repl.open()<CR>                                                  
nnoremap <silent> <leader>dl <Cmd>lua require'dap'.run_last()<CR>                                                   
nnoremap <silent> <leader>du <Cmd>lua require'dapui'.toggle()<CR>                                                   

" Vimtex settings
let g:vimtex_view_general_viewer = 'okular'

" Nerdtree settings
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
nnoremap <C-s> :NERDTreeToggle<Enter>
let NERDTreeIgnore = ['__pycache__']
" Closing on file opening
let NERDTreeQuitOnOpen = 1
" Prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Enables lightline on single file
set laststatus=2
" Lightline settings
" colorscheme
let g:lightline = {
	\ 'colorscheme': 'Tomorrow_Night_Blue',	
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
      	\   'gitbranch': 'FugitiveHead',
				\		'filename': 'LightlineFilename'
      	\ },
\ }
function! LightlineFilename()
	return expand('%')
endfunction

" Clipboard
set clipboard=unnamed

" colorscheme set to 0 to have transparent in transparent terminal
let g:dracula_colorterm = 0
set termguicolors
colorscheme dracula
