call plug#begin()
Plug 'ryanoasis/vim-devicons'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'vimwiki/vimwiki'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" NERDTree

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdtree-project-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" LSP
Plug 'neovim/nvim-lspconfig'

" Git integration

Plug 'tpope/vim-fugitive'

" Linting

" Snippets

" Comments

Plug 'tpope/vim-commentary'

" Themes

Plug 'dracula/vim' , {'as': 'dracula'}

call plug#end() 


" My Stuff
" LSP go stuff
lua require('lsp_config')
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)

let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1

" Tab space
set smartindent
set tabstop=4
set shiftwidth=4
" set expandtab " converts tabs to spaces

" colorscheme set to 0 to have transparent in transparent terminal
let g:dracula_colorterm = 0
colorscheme dracula

" vimwiki stuff
hi link VimwikiLink DraculaLink
hi link VimwikiHeader1 WildMenu 
hi link VimwikiHeader2 DraculaGreenBold
hi link VimwikiList DiffChange 

let g:vimwiki_list = [{'path': '~/OneDrive/Documents/vim/vimwiki',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

let mapleader = " " " map leader to Space
" Horizontal scroll
set nowrap
" Reload vims configuration file
nnoremap <Leader>r :source ~/.config/nvim/init.vim<CR>
" Shortcuts
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Sets line numbers
:set nu
:set rnu

" Session settings
let g:sessions_dir = '~/.config/nvim/sessions'
exec 'nnoremap <Leader>ss :NERDTreeClose \| :mksession! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :wa \| :bufdo bd \| :so ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sd :!rm ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'

" Nerdtree settings
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
nnoremap <C-s> :NERDTreeToggle<Enter>

" Closing on file opening
let NERDTreeQuitOnOpen = 1

" Prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Highlights current file
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()"

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
      	\   'gitbranch': 'FugitiveHead'
      	\ },
\ }
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

" Auto Bracket closing
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>0
" inoremap {;<CR> {<CR>};<ESC>0
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
