" ------------------------------------------------------------------------------
" VUNDLE
" ------------------------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle (required)!
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'groenewege/vim-less'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/gist-vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'nanotech/jellybeans.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on

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
set mousehide
set nocompatible
set noerrorbells
set number
set numberwidth=5
set ruler
set showcmd
set smartindent
set splitbelow
set t_ut=
set t_vb=
set tabstop=2
set shiftwidth=2
set undodir=~/.vim/undo
set wildmode=list:longest
set noshowmode
set encoding=utf-8
set termencoding=utf-8

" ------------------------------------------------------------------------------
" VISUAL SETTINGS
" ------------------------------------------------------------------------------
colorscheme jellybeans

if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
   endif
   set guioptions=m
endif

if has('mouse')
    set mouse=nv
endif

if has('mouse_sgr')
    set ttymouse=sgr
endif

" ------------------------------------------------------------------------------
" Clear search and reenable search with entering and leaving Insert Mode
" ------------------------------------------------------------------------------
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

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
" GENERAL AND BUNDLE CONFIGURATION
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" AIRLINE
" ------------------------------------------------------------------------------
let g:airline_left_sep=''
let g:airline_right_sep=''

" ------------------------------------------------------------------------------
" CtrlP
" ------------------------------------------------------------------------------
let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\v[\/](target|\.(git)|node_modules)$'

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
" MAPPINGS
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" These will make it so that going to the next one in a
" search will center on the line it's found in.
" ------------------------------------------------------------------------------
map N Nzz
map n nzz

" ------------------------------------------------------------------------------
" Handle j and k better for long lines
" ------------------------------------------------------------------------------
nmap j gj
nmap k gk

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
" GENERAL LEADER AND 'OTHER' BINDINGS
" ------------------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>cd :cd %%
map <leader>e :edit %%
map <leader>te :tabe %%
nnoremap <F4> :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
nnoremap <leader>B :CtrlPBuffer<cr>
nnoremap <leader>G :Gist<cr>
nnoremap <leader>a :Ag!<space>
nnoremap <leader>cn :tabe ~/Dropbox/Notes/coding-notes.md<cr>
nnoremap <leader>cs :nohlsearch<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>fef gg=G<cr>``zz
nnoremap <leader>l :set list!<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>v <C-w>v<C-w>l
