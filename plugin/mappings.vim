map <leader>cd :cd %%
map <leader>l :set list!<cr>

" convert horizontally split windows to vertically split
map <leader>htv <C-W>t<C-W>H

" buffer delete
noremap <silent> <leader>bd :bd<CR>

" ------------------------------------------------------------------------------
" Map ,e to open files in the same directory as current file
" ------------------------------------------------------------------------------
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" ------------------------------------------------------------------------------
" Insert mode mappings
" ------------------------------------------------------------------------------
imap jj <esc>

" ------------------------------------------------------------------------------
" Window movement
" ------------------------------------------------------------------------------
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
