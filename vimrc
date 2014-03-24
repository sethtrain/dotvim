" ------------------------------------------------------------------------------
" VUNDLE
" ------------------------------------------------------------------------------
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle (required)!
Bundle 'gmarik/vundle'

" Bundles
Bundle 'Lokaltog/vim-easymotion'
Bundle 'chase/vim-ansible-yaml'
Bundle 'ervandew/supertab'
Bundle 'gregsexton/gitv'
Bundle 'groenewege/vim-less'
Bundle 'guns/vim-clojure-static'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'nanotech/jellybeans.vim'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-sensible'
Bundle 'vim-scripts/paredit.vim'

filetype plugin indent on

" ------------------------------------------------------------------------------
" VISUAL SETTINGS
" ------------------------------------------------------------------------------
set t_Co=256
colorscheme jellybeans

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
" GENERAL SETTINGS
" ------------------------------------------------------------------------------
set autoindent
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set cmdheight=1
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set expandtab
set hidden
set hlsearch
set incsearch
set laststatus=2
set linespace=3
set listchars=tab:▸\ ,eol:¬
set mousehide
set nocompatible
set noerrorbells
set number
set numberwidth=5
set ruler
set shiftwidth=4
set showcmd
set smartindent
set splitbelow
set statusline+=%{fugitive#statusline()}
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set t_vb=
set tabstop=4
set undodir=~/.vim/undo
set wildmode=list:longest

" Use Silver Searcher instead of grep
set grepprg=ag

if has('mouse')
    set mouse=nv
endif

if has('mouse_sgr')
    set ttymouse=sgr
endif

" ------------------------------------------------------------------------------
" Allow backspacing over everything in insert mode
" ------------------------------------------------------------------------------
set backspace=indent,eol,start

" ------------------------------------------------------------------------------
" wildignore settings
" ------------------------------------------------------------------------------
set wildignore+=out,.lein-cljsbuild-compiler*,resources/*,*.pyc,target,node_modules,repl,uploads,*.log,workspace.xml

" ------------------------------------------------------------------------------
" FUN STUFF
" ------------------------------------------------------------------------------
source ~/.vim/say.vim

" ------------------------------------------------------------------------------
" MAPPINGS
" ------------------------------------------------------------------------------

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
" Window movement
" ------------------------------------------------------------------------------
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" ------------------------------------------------------------------------------
" Better file expansion
" ------------------------------------------------------------------------------
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" ------------------------------------------------------------------------------
" GENERAL AND BUNDLE CONFIGURATION
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Enable Rainbow parenthesis
" ------------------------------------------------------------------------------
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ------------------------------------------------------------------------------
" CtrlP
" ------------------------------------------------------------------------------
let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\v[\/](target|\.(git))$'

" ------------------------------------------------------------------------------
" Gist
" ------------------------------------------------------------------------------
let g:gist_clip_command = 'pbcopy'
let g:gist_show_privates = 1
let g:gist_post_private = 1

" ------------------------------------------------------------------------------
" Highlight Trailing Space
" ------------------------------------------------------------------------------
highlight TrailingWhitespace ctermbg=darkgreen guibg=darkgreen
match TrailingWhitespace /\s\+$/
au TabEnter * :match TrailingWhitespace /\s\+$/

" ------------------------------------------------------------------------------
" Trailing space removal on save
" ------------------------------------------------------------------------------
function! StripTrailingSpaces()
    let l = line(".")
    let c = col(".")
    silent! execute '%s/\s\+$//e'
    call cursor(l, c)
endfunction
au BufWritePre * :call StripTrailingSpaces()

" ------------------------------------------------------------------------------
" Rainbow parentheses
" ------------------------------------------------------------------------------
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

" ------------------------------------------------------------------------------
" GENERAL LEADER AND 'OTHER' BINDINGS
" ------------------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

map <F4> :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
map <leader>G :Gist<cr>
map <leader>R :Require<cr>
map <leader>cd :cd %%
map <leader>cn :tabe ~/Dropbox/Notes/coding-notes.md<cr>
map <leader>e :edit %%
map <leader>fef gg=G<cr>``zz
map <leader>ff [[v%==
map <leader>gc :Gcommit -m ""<left>
map <leader>gca :Gcommit -m -a ""<left>
map <leader>gs :Gstatus<cr>
map <leader>htv <C-W>t<C-W>H
map <leader>l :set list!<cr>
map <leader>m :make %<cr>
map <leader>nt :NERDTreeToggle<cr>
map <leader>t :tabnew<cr>
map <leader>te :tabe %%
nnoremap <leader><leader> <c-^>
nnoremap <leader>a <Esc>:Ag!
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>h <C-w>s<C-w>j
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>v <C-w>v<C-w>l
