" Plugins
call plug#begin()
	" Telescope
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-telescope/telescope-ui-select.nvim'
	Plug 'nvim-telescope/telescope-project.nvim'
	Plug 'tami5/sqlite.lua'
	Plug 'nvim-telescope/telescope-cheat.nvim'

	" Treesitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-treesitter/playground'

	" debuging
	Plug 'mfussenegger/nvim-dap'
	Plug 'rcarriga/nvim-dap-ui'

	" LSP
	Plug 'neovim/nvim-lspconfig'
	" completion
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'onsails/lspkind.nvim' " icons of functions. can also define own icons (lookup nvim-cmp wiki -> cuztomize appearance)
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/cmp-path'
	" Vsnip
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'rafamadriz/friendly-snippets'

	" Python
	Plug 'mfussenegger/nvim-dap-python'
	Plug 'jmcantrell/vim-virtualenv'

	" Golang setup
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

	" Typescript setup
	Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

	" Java setup
	Plug 'mfussenegger/nvim-jdtls'

	" Git integration
	Plug 'tpope/vim-fugitive'

	" Comments
	Plug 'tpope/vim-commentary'

	" Colorscheme
	Plug 'dracula/vim' , {'as': 'dracula'}
	
	" Line
	Plug 'itchyny/lightline.vim'
	
	" NERDTree
	Plug 'preservim/nerdtree'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'ryanoasis/vim-devicons'

	" Tmux
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'RyanMillerC/better-vim-tmux-resizer'

	Plug 'lervag/vimtex'
	Plug 'lewis6991/spellsitter.nvim'

	" utils
	Plug 'jiangmiao/auto-pairs'
	Plug 'metakirby5/codi.vim'
	Plug 'luochen1990/rainbow'
	Plug 'glepnir/dashboard-nvim'
	Plug 'rcarriga/nvim-notify'
	Plug 'sbdchd/neoformat'
	Plug 'folke/trouble.nvim'
call plug#end() 


function! MyHighlights() abort
		highlight link FloatBorder CmpPmenuBorder
		highlight! link Pmenu CmpPmenu

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

" enable mouse in all modes
set mouse=a

lua require('mydap')
lua require('mytrouble')
lua require('mynotify')
" Treesitter
lua require('treesitter')


" completion menu and mappings
lua require('completion')

" LSP go stuff
lua require('lsp_config')
autocmd BufWritePre *.go lua goimports(1000)
set completeopt=menu,menuone,noselect

" Treesitter does everything now
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_types = 1
let g:go_rename_command = 'gopls'

" Tab space
set smartindent
set tabstop=2
set shiftwidth=2
" set expandtab " converts tabs to spaces
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

let mapleader = " " " map leader to Space
let maplocalleader = " " " filetype specifc leader key
" Horizontal scroll
set nowrap
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

lua require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

" trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap <leader>xr <cmd>TroubleToggle lsp_references<cr>

let g:neoformat_try_node_exe = 1
autocmd BufWritePre *.js silent! Neoformat
autocmd BufWritePre *.ts silent! Neoformat
                                                                 
" Shortcuts
map <C-S-h> 5<C-w><
map <C-S-j> 5<C-w>+
map <C-S-k> 5<C-w>-
map <C-S-l> 5<C-w>>

" Telescope
lua require('mytelescope')

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>t <cmd>Telescope treesitter<cr>
nnoremap <leader>wd <cmd>Telescope diagnostics<cr>
nnoremap <leader>ws <cmd>Telescope project<cr>

" Sets line numbers
:set nu
:set rnu

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
" Transparecy
" autocmd VimEnter * call SetupLightlineColors()
" function SetupLightlineColors() abort
"   " transparent background in statusbar
"   let l:palette = lightline#palette()
" 
"   let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
"   let l:palette.inactive.middle = l:palette.normal.middle
"   let l:palette.tabline.middle = l:palette.normal.middle
" 
"   call lightline#colorscheme()
" endfunction
"
"
" Save easier
nnoremap zz :w<cr>
" and goto cursor and Insert mod
" inoremap zz <ESC>:w<cr>gi
inoremap zz <ESC>:w<cr>

" Encoding
set encoding=utf-8

" Clipboard
set clipboard=unnamed

"Git fugitiv plugin maps
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

" No Highlight
nnoremap <Leader>h :noh <cr>

" colorscheme set to 0 to have transparent in transparent terminal
let g:dracula_colorterm = 0
set termguicolors
colorscheme dracula
