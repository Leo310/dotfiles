
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" My Stuff
" Horizontal scroll
set nowrap
" Reload vims configuration file
nnoremap <Leader>r :source ~/.vimrc<CR>
" Shortcuts
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Sets vim colorscheme
packadd! dracula
colorscheme dracula

" Sets line numbers
:set nu
:set rnu

" Session settings
let g:sessions_dir = '~/.vim/sessions'
exec 'nnoremap <Leader>ss :NERDTreeClose \| :mksession! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :bufdo bd \| :so ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
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
	\ 'colorscheme': 'darcula',	
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
