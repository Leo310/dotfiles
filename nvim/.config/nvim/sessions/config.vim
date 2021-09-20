let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +2 nvim/.config/nvim/init.vim
badd +3 tmux/.tmux.conf
badd +10 bash/.bashrc
argglobal
%argdel
edit nvim/.config/nvim/init.vim
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 95 + 95) / 190)
exe '2resize ' . ((&lines * 25 + 26) / 52)
exe 'vert 2resize ' . ((&columns * 94 + 95) / 190)
exe '3resize ' . ((&lines * 24 + 26) / 52)
exe 'vert 3resize ' . ((&columns * 94 + 95) / 190)
argglobal
balt tmux/.tmux.conf
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists("bash/.bashrc") | buffer bash/.bashrc | else | edit bash/.bashrc | endif
if &buftype ==# 'terminal'
  silent file bash/.bashrc
endif
balt tmux/.tmux.conf
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists("tmux/.tmux.conf") | buffer tmux/.tmux.conf | else | edit tmux/.tmux.conf | endif
if &buftype ==# 'terminal'
  silent file tmux/.tmux.conf
endif
balt nvim/.config/nvim/init.vim
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 3 - ((1 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 95 + 95) / 190)
exe '2resize ' . ((&lines * 25 + 26) / 52)
exe 'vert 2resize ' . ((&columns * 94 + 95) / 190)
exe '3resize ' . ((&lines * 24 + 26) / 52)
exe 'vert 3resize ' . ((&columns * 94 + 95) / 190)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
