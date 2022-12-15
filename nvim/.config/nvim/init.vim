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
