" ------------------------------------------------------------------------------
" vim-plug
" ------------------------------------------------------------------------------
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" Sensible defaults
Plug 'tpope/vim-sensible'

" Plugins
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'nanotech/jellybeans.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

" ------------------------------------------------------------------------------
" Language Specific Plugins
" ------------------------------------------------------------------------------

" Python
Plug 'davidhalter/jedi-vim'
Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()
filetype plugin indent on

" ------------------------------------------------------------------------------
" VISUAL SETTINGS
" ------------------------------------------------------------------------------
colorscheme jellybeans

" ------------------------------------------------------------------------------
" GENERAL SETTINGS
" ------------------------------------------------------------------------------
set autowrite
set autoread
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backspace=indent,eol,start
set clipboard=unnamed
set cmdheight=1
set cursorline
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set expandtab
set hidden
set mouse=a
set number
set noerrorbells
set noshowmode
set nowrap
set shiftwidth=4
set shortmess+=Ic
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set tags=./tags
set termencoding=utf-8
set timeoutlen=500
set undodir=~/.vim/undo
set undofile
set undolevels=500
set undoreload=5000
set wildmode=list:longest,full

" ------------------------------------------------------------------------------
" wildignore settings
" ------------------------------------------------------------------------------
set wildignore+=out,.lein-cljsbuild-compiler*,*.pyc,node_modules,repl,uploads,*.log,workspace.xml,vendor,__pycache__

" ------------------------------------------------------------------------------
" ALE
" ------------------------------------------------------------------------------
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" ------------------------------------------------------------------------------
" airline
" ------------------------------------------------------------------------------
let g:airline_powerline_fonts = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_z = ''

" ------------------------------------------------------------------------------
" Better whitespace
" ------------------------------------------------------------------------------
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" ------------------------------------------------------------------------------
" FZF
" ------------------------------------------------------------------------------
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'ag --ignore "venv" --ignore "vendor" --ignore "*.pyc" --ignore "datadir" --ignore "tmp" --ignore "node_modules" --ignore "build" --ignore "gradle" --ignore "gradlew.bat" --ignore "gradlew" -l -U -g ""'

" ------------------------------------------------------------------------------
" LSP
" ------------------------------------------------------------------------------
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ })
endif
let g:lsp_diagnostics_enabled = 0

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
let NERDTreeIgnore = ['\.pyc$', 'datadir', 'node_modules', '__pycache__']

" ------------------------------------------------------------------------------
" Vimux
" ------------------------------------------------------------------------------
" let g:VimuxOrientation = "h"
" let g:VimuxHeight = "50"

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
nmap <F4> :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
nmap <F3> :TagbarToggle<CR>
map <C-N> :NERDTreeToggle<cr>
map <C-P> :Files<cr>
map <leader>B :Buffers<cr>
map <leader>D :Dispatch<cr>
map <leader>N :ALENext<cr>
map <leader>P :ALEPrevious<cr>
map <leader>aa :A<cr>
map <leader>a :Ag<cr>
map <leader>bd :bd<cr>
map <leader>ev :e ~/.vim/vimrc<cr>
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
let g:pre_runner_ran = 0
let g:pre_runner = $PRE_RUNNER
let g:test_runner = $TEST_RUNNER
let g:test_location = $TEST_LOCATION
let g:build_runner = $BUILD_RUNNER
let g:runner = $RUNNER

function! OpenRunner()
    let g:pre_runner_ran = 1
    call VimuxRunCommand(g:pre_runner)
endfunction

function! RunCurrentTest()
    if g:pre_runner_ran == 0
        call OpenRunner()
    endif
    let buffer = bufname("%")
    call VimuxSendKeys("C-l")
    call VimuxRunCommand(g:test_runner . " ". buffer)
endfunction

function! RunLastTest()
    if g:pre_runner_ran == "false"
        call OpenRunner()
    endif
    call VimuxSendKeys("C-l")
    call VimuxRunLastCommand()
endfunction

function! RunAllTests()
    if g:pre_runner_ran == "false"
        call OpenRunner()
    endif
    call VimuxSendKeys("C-l")
    call VimuxRunCommand(g:test_runner . " " . g:test_location)
endfunction

function! RunBuild()
    if g:pre_runner_ran == "false"
        call OpenRunner()
    endif
    call VimuxSendKeys("C-l")
    call VimuxRunCommand(g:build_runner)
endfunction

function! RunRunner()
    if g:pre_runner_ran == "false"
        call OpenRunner()
    endif
    call VimuxSendKeys("C-l")
    call VimuxRunCommand(g:runner)
endfunction

function! VimuxCancel()
    let g:pre_runner_ran = 0
    call VimuxSendKeys("C-l")
    call VimuxSendKeys("C-c")
endfunction

map <silent> <leader>ra :call RunAllTests()<cr>
map <silent> <leader>rb :call RunBuild()<cr>
map <silent> <leader>rf :call RunCurrentTest()<cr>
map <silent> <leader>rl :call RunLastTest()<cr>
map <silent> <leader>rr :call RunRunner()<cr>
map <silent> <leader>vc :call VimuxCancel()<cr>
map <silent> <leader>vq :call VimuxCloseRunner()<cr>
map <silent> <leader>vx :VimuxInterruptRunner<cr>


func! s:SetBreakpoint()
    cal append('.', repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import pdb; pdb.set_trace()')
endf

func! s:RemoveBreakpoint()
    exe 'silent! g/^\s*import\spdb\;\?\n*\s*pdb.set_trace()/d'
endf

func! s:ToggleBreakpoint()
    if getline('.')=~#'^\s*import\spdb' | cal s:RemoveBreakpoint() | el | cal s:SetBreakpoint() | en
endf
nnoremap <leader>bp :call <SID>ToggleBreakpoint()<CR>

function! ToggleQuickfix()
    for buffer in tabpagebuflist()
        if bufname(buffer) == ''
            cclose
            return
        endif
    endfor

    copen
endfunction
nnoremap <leader>c :call ToggleQuickfix()<CR>

if filereadable("pelicanconf.py")
    nmap <leader>G :Dispatch pipenv run generate<cr>
    nmap <leader>R :Dispatch pipenv run preview<cr>
endif
