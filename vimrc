" -----------------------------------------------------------------------------
" Pathogen
" -----------------------------------------------------------------------------
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if has("autocmd")
    filetype plugin indent on
endif

" ------------------------------------------------------------------------------
" Visual Settings
" ------------------------------------------------------------------------------
set t_Co=256
colorscheme sethtrain

" ------------------------------------------------------------------------------
" General Settings
" ------------------------------------------------------------------------------
set ruler
set hidden
set number
set numberwidth=5
set wildmode=list:longest
set smartindent
set autoindent
set laststatus=2
set linespace=3
set splitbelow
set hlsearch
set incsearch
set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set mousehide
set showcmd
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set statusline+=%{fugitive#statusline()}
set noerrorbells
set t_vb=
set cmdheight=1
set listchars=tab:▸\ ,eol:¬
set undodir=~/.vim/undo

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

if has('mouse')
    set mouse=nv
endif

if has('mouse_sgr')
    set ttymouse=sgr
endif

" ------------------------------------------------------------------------------
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" ------------------------------------------------------------------------------
" ------------------------------------------------------------------------------
" Gui options
" ------------------------------------------------------------------------------
if &t_Co > 2 || has("gui_running")
    syntax on
    if has("gui_gtk2")
        set guifont=Droid\ Sans\ Mono\ 12
    elseif has("gui_macvim")
        set guifont=Droid\ Sans\ Mono:h12
    end
    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R
    set go-=m
    highlight iCursor guifg=white guibg=#0087af
    set guicursor=n-c:block-Cursor-blinkon0
    set guicursor+=v:block-vCursor-blinkon0
    set guicursor+=i-ci:ver20-iCursor
endif

" ------------------------------------------------------------------------------
" MY leader key
" ------------------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

" ------------------------------------------------------------------------------
" wildignore settings
" ------------------------------------------------------------------------------
set wildignore+=out,.lein-cljsbuild-compiler*,resources/*,*.pyc,target,node_modules,repl,uploads

" ------------------------------------------------------------------------------
" Source .vimrc when saved
" ------------------------------------------------------------------------------
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

" ------------------------------------------------------------------------------
" These will make it so that going to the next one in a
" search will center on the line it's found in.
" ------------------------------------------------------------------------------
map N Nzz
map n nzz

" ------------------------------------------------------------------------------
" Fixes strange issue when using vim (terminal) within tmux
" ------------------------------------------------------------------------------
map <Esc>[B <Down>

" ------------------------------------------------------------------------------
" Switch between the last two files
" ------------------------------------------------------------------------------
nnoremap <leader><leader> <c-^>

" ------------------------------------------------------------------------------
" Opens a vertical split and switches over
" ------------------------------------------------------------------------------
nnoremap <leader>v <C-w>v<C-w>l

" ------------------------------------------------------------------------------
" Opens a horizontal split and switches over
" ------------------------------------------------------------------------------
nnoremap <leader>h <C-w>s<C-w>j

" ------------------------------------------------------------------------------
" Saves time
" ------------------------------------------------------------------------------
nnoremap <space> :

" ------------------------------------------------------------------------------
" Normal mode mappings
" ------------------------------------------------------------------------------
nnoremap <leader>ev :tabe $MYVIMRC<cr>

" ------------------------------------------------------------------------------
" Allow backspacing over everything in insert mode
" ------------------------------------------------------------------------------
set backspace=indent,eol,start

" ------------------------------------------------------------------------------
" Enable Rainbow parenthesis
" ------------------------------------------------------------------------------
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ------------------------------------------------------------------------------
" Handle hlsearch better
" ------------------------------------------------------------------------------
function! MapCR()
    nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" ------------------------------------------------------------------------------
" Map ,e to open files in the same directory as current file
" ------------------------------------------------------------------------------
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>te :tabe %%

" ------------------------------------------------------------------------------
" Insert mode mappings
" ------------------------------------------------------------------------------
inoremap jj <esc>

" ------------------------------------------------------------------------------
" Window movement
" ------------------------------------------------------------------------------
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" -----------------------------------------------------------------------------
" Coding Notes (idea from Ben Orenstein)
" -----------------------------------------------------------------------------
map <leader>cn :tabe ~/Dropbox/Notes/coding-notes.md<cr>

" ------------------------------------------------------------------------------
" General Bindings and plugin options
" ------------------------------------------------------------------------------

" Make
map <leader>m :make %<cr>

" Set mapping for paste
map <F4> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>

" Format Entire File
map <leader>fef gg=G<cr>``zz

" Format function
map <leader>ff [[v%==

map <leader>cd :cd %%
map <leader>l :set list!<cr>

" convert horizontally split windows to vertically split
map <leader>htv <C-W>t<C-W>H

" buffer delete
" noremap <silent> <leader>bd :bd<CR>
source ~/.vim/bclose.vim

" Ack
nnoremap <leader>a <Esc>:Ack!

" CtrlP
function! ClearCtrlPState()
  :let g:ctrlp_default_input = ''
endfunction

function! SetCtrlPDefaultInputToCword()
  :let g:ctrlp_default_input = expand('<cword>')
endfunction

" CtrlP
let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = ''
let g:ctrlp_custom_ignore = '\v[\/](target|\.(git))$'
nn <leader>t :call ClearCtrlPState()<cr>:CtrlP<cr>
nn <leader>T :call SetCtrlPDefaultInputToCword()<cr>:CtrlP<cr>
nn <leader>b :call ClearCtrlPState()<cr>:CtrlPBuffer<cr>
nn <leader>B :call SetCtrlPDefaultInputToCword()<cr>:CtrlPBuffer<cr>
" Jump to declaration
nn <F5> :call ClearCtrlPState()<cr>:let g:ctrlp_default_input = substitute(expand('<cword>'), '.*/', '', '')<cr>:CtrlPTag<cr>

" Highlight Trailing Space
highlight TrailingWhitespace ctermbg=darkgreen guibg=darkgreen
match TrailingWhitespace /\s\+$/
au TabEnter * :match TrailingWhitespace /\s\+$/

" Trailing space removal on save
function! StripTrailingSpaces()
    let l = line(".")
    let c = col(".")
    silent! execute '%s/\s\+$//e'
    call cursor(l, c)
endfunction
au BufWritePre * :call StripTrailingSpaces()

" Rainbow parentheses
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]

" Go
autocmd FileType go compiler go
map <leader>g :Godoc<cr>
