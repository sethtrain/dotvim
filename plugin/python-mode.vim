" let g:pymode_breakpoint_key = '<leader>pb'

" autocmd FileType python set omnifunc=pythoncomplete#Complete
" let g:SuperTabDefaultCompletionType = "context"
" set completeopt=menuone,longest,preview

" let g:pymode_lint_ignore = "E501,W901"

let g:pymode_lint = 0

" Flake8
autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
let g:flake8_ignore="E501,W293,W901"
autocmd BufWritePost *.py call Flake8()
