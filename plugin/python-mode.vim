let g:pymode_breakpoint_key = '<leader>pb'

autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

let g:pymode_lint_ignore = "E501,W901"
