" ------------------------------------------------------------------------------
" Vundle
" ------------------------------------------------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Sensible defaults
Plugin 'tpope/vim-sensible'

" Everyday plugins
Plugin 'Lokaltog/vim-easymotion'
Plugin 'airblade/vim-gitgutter'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/fzf.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-surround'

" Colors
Plugin 'flazz/vim-colorschemes'


call vundle#end()
filetype plugin indent on

" ------------------------------------------------------------------------------
" VISUAL SETTINGS
" ------------------------------------------------------------------------------
colorscheme grb256

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set clipboard=unnamed
set cmdheight=1
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set expandtab
set hidden
set mouse=a
set noerrorbells
set nofoldenable
set noshowmode
set number
set splitbelow
set splitright
set tabstop=2
set termencoding=utf-8
set undodir=~/.vim/undo
set undofile
set undolevels=500
set undoreload=5000
set wildmode=list:longest,full

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=500

" ------------------------------------------------------------------------------
" wildignore settings
" ------------------------------------------------------------------------------
set wildignore+=out,.lein-cljsbuild-compiler*,*.pyc,node_modules,repl,uploads,*.log,workspace.xml

" ------------------------------------------------------------------------------
" Fzf
" ------------------------------------------------------------------------------
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

" ------------------------------------------------------------------------------
" Vimux
" ------------------------------------------------------------------------------
let g:VimuxOrientation = "h"
let g:VimuxHeight = "50"

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

nnoremap <C-h> <C-w-h>
nnoremap <C-j> <C-w-j>
nnoremap <C-k> <C-w-k>
nnoremap <C-l> <C-w-l>

" ------------------------------------------------------------------------------
" Hack to get C-h working in NeoVim
" ------------------------------------------------------------------------------
nmap <BS> <C-W>h

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
cnoremap %% <C-R>=expand('%:p:h').'/'<cr>

" ------------------------------------------------------------------------------
" GENERAL LEADER AND 'OTHER' BINDINGS
" ------------------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

" Thanks Apple touch bar
imap jj <Esc>
map <F4> :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
map <C-P> :Files<CR>
map <leader>B :Buffers<CR>
map <leader>G :Gist<cr>
map <leader>a :Ag!<space>--vimgrep<space>
map <leader>bd :bd<cr>
map <leader>cd :cd %%
map <leader>cn :e ~/Dropbox/notes/coding-notes.txt<cr>
map <leader>cs :let @/ = "" \| nohlsearch<cr>
map <leader>e :edit %%
map <leader>ev :e ~/.vim/vimrc<cr>
map <leader>fef gg=G<cr>``zz
map <leader>gc :Gcommit -m ""<left>
map <leader>gca :Gcommit -m -a ""<left>
map <leader>gs :Gstatus<cr>
map <leader>l :set list!<cr>
map <leader>te :tabe %%
map <leader>v <C-w>v<C-w>l
map <leader>> :vertical resize +5<cr>
map <leader>< :vertical resize -5<cr>

" Source file in vim (helpful when working with plugin)
map <leader>so :w \| :so %<cr>

" Disable Ex mode
nnoremap Q <Nop>

" ------------------------------------------------------------------------------
" Vimux functions and mappings
" ------------------------------------------------------------------------------
let g:test_runner = "./manage.py test"
let g:test_location = ""

function! RunCurrentTest()
  let buffer = bufname("%")
  call VimuxSendKeys("C-l")
  call VimuxRunCommand(g:test_runner . " ". buffer)
endfunction

function! RunAllTests()
  call VimuxSendKeys("C-l")
  call VimuxRunCommand(g:test_runner . " " . g:test_location)
endfunction

function! RunTut()
  call VimuxSendKeys("C-l")
  call VimuxRunCommand("sbt tut")
endfunction

map <silent> <leader>r :call RunCurrentTest()<cr>
map <silent> <leader>ra :call RunAllTests()<cr>
map <silent> <leader>rt :call RunTut()<cr>
map <silent> <leader>vl :VimuxRunLastCommand<cr>
map <silent> <leader>vq :VimuxCloseRunner<cr>
map <silent> <leader>vx :VimuxInterruptRunner<cr>

