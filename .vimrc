
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
" Shortcuts
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Sets line numbers
:set nu
:set rnu

" Session settings
let g:sessions_dir = '~/.vim/sessions'
exec 'nnoremap <Leader>ss :NERDTreeClose \| :mksession! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :bufdo bd \| :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sd :!rm ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" Nerdtree settings
" Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif

" Directly open NerdTree on editing file
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
nnoremap <C-s> :NERDTreeToggle<Enter>

" Closing on file opening
let NERDTreeQuitOnOpen = 1
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


" Lightline settings
" colorscheme
let g:lightline = {
      \ 'colorscheme': 'molokai',
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
