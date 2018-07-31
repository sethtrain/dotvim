" ------------------------------------------------------------------------------
" vim-plug
" ------------------------------------------------------------------------------
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" Sensible defaults
Plug 'tpope/vim-sensible'

" Plugins
Plug 'Lokaltog/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'nanotech/jellybeans.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-db'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'

" ------------------------------------------------------------------------------
" Completion
" ------------------------------------------------------------------------------
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go'
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

" ------------------------------------------------------------------------------
" Language Specific Plugins
" ------------------------------------------------------------------------------

" Go
Plug 'fatih/vim-go'

" Rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'ngmy/vim-rubocop'

" Python
Plug 'davidhalter/jedi-vim'

call plug#end()
filetype plugin indent on

" ------------------------------------------------------------------------------
" VISUAL SETTINGS
" ------------------------------------------------------------------------------
colorscheme jellybeans

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
set nowrap
set number
set shiftwidth=4
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set termencoding=utf-8
set undodir=~/.vim/undo
set undofile
set undolevels=500
set undoreload=5000
set wildmode=list:longest,full

" Don't wait so long for the next keypress (particularly in ambigious Leader situations.
set timeoutlen=500

" ------------------------------------------------------------------------------
" wildignore settings
" ------------------------------------------------------------------------------
set wildignore+=out,.lein-cljsbuild-compiler*,*.pyc,node_modules,repl,uploads,*.log,workspace.xml,vendor

" ------------------------------------------------------------------------------
" Fzf
" ------------------------------------------------------------------------------
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'ag --ignore "venv" --ignore "vendor" --ignore "*.pyc" --ignore "datadir" --ignore "tmp" --ignore "node_modules" -l -U -g ""'

" ------------------------------------------------------------------------------
" Go
" ------------------------------------------------------------------------------
let g:go_fmt_command = "goimports"

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
let NERDTreeIgnore = ['\.pyc$', 'datadir', 'node_modules']

" ------------------------------------------------------------------------------
" SQL
" ------------------------------------------------------------------------------
let g:sql_type_default = 'pgsql'

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
" These will make it so that going to the next one in a
" search will center on the line it's found in.
" ------------------------------------------------------------------------------
map N Nzz
map n nzz

" ------------------------------------------------------------------------------
" Handle j and k better for long lines that are wrapped
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
map <C-N> :NERDTreeToggle<cr>
map <C-P> :Files<cr>
vmap <C-/> :Commentary<cr>
map <leader>B :Buffers<cr>
map <leader>aa :A<cr>
map <leader>a :Ag<cr>
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
map <leader>t :TagbarToggle<cr>
map <leader>v <C-w>v<C-w>l
map <leader>> :vertical resize +5<cr>
map <leader>< :vertical resize -5<cr>

" Source file in vim (helpful when working with plugin)
map <leader>so :w \| :so %<cr>

" Disable Ex mode
nnoremap Q <Nop>

" Go specific Leader commands
au FileType go nmap <leader>d <Plug>(go-doc)

function! GoRunInVmux()
    call VimuxSendKeys("C-l")
    call VimuxRunCommand("go run " . bufname("%"))
endfunction

augroup go
    autocmd!

    " :GoTest
    autocmd FileType go nmap <leader>t  <Plug>(go-test)

    " :GoRun
    "autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <silent> <leader>r :call GoRunInVmux()<cr>

    " :GoDoc
    autocmd FileType go nmap <Leader>d <Plug>(go-doc)

    " :GoCoverageToggle
    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

    " :GoInfo
    autocmd FileType go nmap <Leader>i <Plug>(go-info)

    " :GoMetaLinter
    autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

    " :GoDef but opens in a vertical split
    autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)

    " :GoDef but opens in a horizontal split
    autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

    " :GoAlternate  commands :A, :AV, :AS and :AT
    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" ------------------------------------------------------------------------------
" Vimux functions and mappings
" ------------------------------------------------------------------------------
let g:test_runner = "go test"
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

function! VimuxCancel()
    call VimuxSendKeys("C-l")
    call VimuxSendKeys("C-c")
endfunction

map <silent> <leader>q :VimuxCloseRunner<cr>
map <silent> <leader>ra :call RunAllTests()<cr>
map <silent> <leader>rf :call RunCurrentTest()<cr>
map <silent> <leader>rl :VimuxRunLastCommand<cr>
map <silent> <leader>vq :call VimuxCancel()<cr>
map <silent> <leader>vx :VimuxInterruptRunner<cr>

