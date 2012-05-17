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
colorscheme molokai
set t_Co=256
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
set foldenable
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set statusline+=%{fugitive#statusline()}
set noerrorbells
set visualbell
set t_vb=
"set cursorline
set cmdheight=1
set nonumber
set listchars=tab:▸\ ,eol:¬

" ------------------------------------------------------------------------------
" Powerline settings
" ------------------------------------------------------------------------------
let g:Powerline_cache_enabled = 1
let g:Powerline_symbols = "fancy"

" ------------------------------------------------------------------------------
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" ------------------------------------------------------------------------------
" ------------------------------------------------------------------------------
" Gui options
" ------------------------------------------------------------------------------
if &t_Co > 2 || has("gui_running")
  syntax on
  set guifont=Droid\ Sans\ Mono\ for\ Powerline:h18
  set go-=T
  set go-=l
  set go-=L
  set go-=r
  set go-=R
  highlight iCursor guifg=white guibg=#0087af
  set guicursor=n-c:block-Cursor-blinkon0
  set guicursor+=v:block-vCursor-blinkon0
  set guicursor+=i-ci:ver20-iCursor
endif

" ------------------------------------------------------------------------------
" Backup
" ------------------------------------------------------------------------------
set backupdir=~/.vim/backup

" ------------------------------------------------------------------------------
" MY leader key
" ------------------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

" ------------------------------------------------------------------------------
" May the force be with you -- things that force me to use vim properly
" ------------------------------------------------------------------------------
" map <Left> :echo "no!"<cr>
" map <Right> :echo "no!"<cr>
" map <Up> :echo "no!"<cr>
" map <Down> :echo "no!"<cr>

" ------------------------------------------------------------------------------
" General mappings
" ------------------------------------------------------------------------------
map <leader>cd :cd %%
map <leader>l :set list!<cr>
" convert horizontally split windows to vertically split
map <leader>htv <C-W>t<C-W>H

" ------------------------------------------------------------------------------
" Buffer commands
" ------------------------------------------------------------------------------
noremap <silent> <leader>bd :bd<CR>

" ------------------------------------------------------------------------------
" wildignore settings
" ------------------------------------------------------------------------------
set wildignore+=*.pyc

" ------------------------------------------------------------------------------
" Source .vimrc when saved
" ------------------------------------------------------------------------------
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" ------------------------------------------------------------------------------
" Map ,e and ,v to open files in the same directory as current file
" ------------------------------------------------------------------------------
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" ------------------------------------------------------------------------------
" Rename file
" ------------------------------------------------------------------------------
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':savass' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

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
" Saves time
" ------------------------------------------------------------------------------
nmap <space> :

" ------------------------------------------------------------------------------
" Normal mode mappings
" ------------------------------------------------------------------------------
nmap <leader>ev :edit $MYVIMRC<cr>

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

" ------------------------------------------------------------------------------
" Allow backspacing over everything in insert mode
" ------------------------------------------------------------------------------
set backspace=indent,eol,start

" ------------------------------------------------------------------------------
" Ack settings
" ------------------------------------------------------------------------------
nmap <leader>a <Esc>:Ack!

" ------------------------------------------------------------------------------
" CtrlP settings
" ------------------------------------------------------------------------------
let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = ''
map <leader>t :CtrlP<cr>
map <leader>b :CtrlPBuffer<cr>

" ------------------------------------------------------------------------------
" pep8 settings
" ------------------------------------------------------------------------------
let g:pep8_map='<leader>8'

" ------------------------------------------------------------------------------
" Pyflakes settings
" ------------------------------------------------------------------------------
let g:pyflakes_use_quickfix = 0

" ------------------------------------------------------------------------------
" Python autocomplete
" ------------------------------------------------------------------------------
autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" ------------------------------------------------------------------------------
" Trailing Space Helpers
" ------------------------------------------------------------------------------
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

" -------------------------------------------------------------------------------
" Gist
" -------------------------------------------------------------------------------
let g:gist_show_privates = 1

map <leader>gb :Gist -p<cr>
map <leader>gbs :Gist -p -m<cr>

" -------------------------------------------------------------------------------
" Gundo
" -------------------------------------------------------------------------------
map <leader>gt :GundoToggle<cr>

" -------------------------------------------------------------------------------
" NERDTree
" -------------------------------------------------------------------------------
map <leader>nt :NERDTreeToggle<cr>
