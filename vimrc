" ------------------------------------------------------------------------------
" Vundle
" ------------------------------------------------------------------------------
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'gmarik/Vundle.vim'

" Sensible defaults
Plug 'tpope/vim-sensible'

" Plugins
Plug 'Lokaltog/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/targets.vim'

" ------------------------------------------------------------------------------
" Completion
" ------------------------------------------------------------------------------
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-go'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'zchee/deoplete-go'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" ------------------------------------------------------------------------------
" Language Specific Plugins
" ------------------------------------------------------------------------------
Plug 'fatih/vim-go'

call plug#end()
filetype plugin indent on

" ------------------------------------------------------------------------------
" VISUAL SETTINGS
" ------------------------------------------------------------------------------
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

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
let $FZF_DEFAULT_COMMAND = 'ag --ignore "*.pyc" --ignore "datadir" --ignore "node_modules" -l -U -g ""'

" Allow for FZF to respect colorscheme
function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END

" ------------------------------------------------------------------------------
" Go
" ------------------------------------------------------------------------------
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

" ------------------------------------------------------------------------------
" JSON
" ------------------------------------------------------------------------------
au BufNewFile,BufRead *.json setlocal noet ts=4 sw=4 sts=4

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
" MAPPINGS
" ------------------------------------------------------------------------------

nnoremap <C-h> <C-w-h>
nnoremap <C-j> <C-w-j>
nnoremap <C-k> <C-w-k>
nnoremap <C-l> <C-w-l>

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
map <C-N> :NERDTreeToggle<CR>
map <C-P> :CtrlP<CR>
vmap <C-/> :Commentary<CR>
map <leader>B :CtrlPBuffer<CR>
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

" ------------------------------------------------------------------------------
" Vimux functions and mappings
" ------------------------------------------------------------------------------
let g:test_runner = "nosetests"
let g:test_location = "tests"

function! RunCurrentTest()
  let buffer = bufname("%")
  call VimuxSendKeys("C-l")
  call VimuxRunCommand(g:test_runner . " ". buffer)
endfunction

function! RunAllTests()
  call VimuxSendKeys("C-l")
  call VimuxRunCommand(g:test_runner . " " . g:test_location)
endfunction

map <silent> <leader>ra :call RunAllTests()<cr>
map <silent> <leader>rf :call RunCurrentTest()<cr>
map <silent> <leader>rl :VimuxRunLastCommand<cr>
map <silent> <leader>vq :VimuxCloseRunner<cr>
map <silent> <leader>vx :VimuxInterruptRunner<cr>

