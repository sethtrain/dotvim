" ------------------------------------------------------------------------------
" VUNDLE
" ------------------------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle (required)!
Plugin 'gmarik/Vundle.vim'

" General Plugins
Plugin 'Lokaltog/vim-easymotion'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'diepm/vim-rest-console'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rizzatti/dash.vim'
Plugin 'rking/ag.vim'
Plugin 'szw/vim-g'

" tpope plugins
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'

" Colors
Plugin 'flazz/vim-colorschemes'

" Rails
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'thoughtbot/vim-rspec'

" Ruby
Plugin 'vim-ruby/vim-ruby'

" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-salve'
Plugin 'venantius/vim-cljfmt'
Plugin 'vim-scripts/paredit.vim'

" Ultisnips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

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
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set incsearch
set laststatus=2
set mousehide
set nocompatible
set noerrorbells
set nofoldenable
set noshowmode
set number
set relativenumber
set numberwidth=5
set ruler
set shiftwidth=2
set showcmd
set smartindent
set splitbelow
set splitright
set t_ut=
set t_vb=
set tabstop=2
set termencoding=utf-8
set undodir=~/.vim/undo
set undofile
set undolevels=500
set undoreload=5000
set wildmenu
set wildmode=list:longest,full

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=500

" Enable built-in matchit plugin
runtime macros/matchit.vim

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
let g:airline#extensions#tabline#enabled = 1

" ------------------------------------------------------------------------------
" Cljfmt
" ------------------------------------------------------------------------------
let g:clj_fmt_autosave = 0

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
" Ultisnips
" ------------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" ------------------------------------------------------------------------------
" Vim REST Console
" ------------------------------------------------------------------------------
let g:vrc_set_default_mapping = 0
let g:vrc_include_response_header = 0
autocmd BufWritePre,BufRead es.rest :let $http_proxy = "socks5://localhost:1337"
autocmd BufWritePre,BufRead es.rest :let g:vrc_header_content_type = 'application/x-www-form-urlencoded'

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
" Better file expansion
" ------------------------------------------------------------------------------
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" ------------------------------------------------------------------------------
" GENERAL LEADER AND 'OTHER' BINDINGS
" ------------------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <F4> :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
map <leader>B :CtrlPBuffer<CR>
map <leader>G :Gist<cr>
map <leader>a :Ag!<space>
map <leader>bd :bd<cr>
map <leader>cd :cd %%
map <leader>cn :e ~/Dropbox/notes/coding-notes.txt<cr>
map <leader>cs :nohlsearch<cr>
map <leader>e :edit %%
map <leader>es :e ~/projects/cicayda/es.rest<cr>
map <leader>ev :e $MYVIMRC<cr>
map <leader>fef gg=G<cr>``zz
map <leader>g :call VrcQuery()<cr>
map <leader>gc :Gcommit -m ""<left>
map <leader>gca :Gcommit -m -a ""<left>
map <leader>gs :Gstatus<cr>
map <leader>l :set list!<cr>
map <leader>sv :source $MYVIMRC<cr>
map <leader>t :CtrlPTag<cr>
map <leader>te :tabe %%
map <leader>v <C-w>v<C-w>l

" Source file in vim (helpful when working with plugin)
map <leader>so :w \| :so %<cr>

" Disable Ex mode
nnoremap Q <Nop>

" ------------------------------------------------------------------------------
" RENAME CURRENT FILE (thanks Gary Bernhardt)
" ------------------------------------------------------------------------------
function! RenameFile()
let old_name = expand('%')
let new_name = input('New file name: ', expand('%'), 'file')
if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <Leader>n :call RenameFile()<cr>

function! RelNumberToggle()
  if(&relativenumber == 1)
    set relativenumber!
  else
    set relativenumber
  endif
endfunc

nnoremap <leader>trn :call RelNumberToggle()<cr>

