call plug#begin()
Plug 'ryanoasis/vim-devicons'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'vimwiki/vimwiki'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" NERDTree

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdtree-project-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

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
" colorscheme set to 0 to have transparent in transparent terminal
let g:dracula_colorterm = 0
colorscheme dracula

let mapleader = " " " map leader to Space
" Horizontal scroll
set nowrap
" Reload vims configuration file
nnoremap <Leader>r :source ~/.vimrc<CR>
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
let g:sessions_dir = '~/.vim/sessions'
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
" Youcompleteme settings
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

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

"Youcompleteme dont open split window  with function completion 
set completeopt-=preview

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
