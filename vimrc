filetype off
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
colorscheme brookstream
syntax on
set ruler
set hidden
if has("gui_gtk2")
    set guifont=Inconsolata\ 15
elseif has("gui_macvim")
    set guifont=Inconsolata:h15
end
set number
set wildmode=list:longest
set smartindent
set autoindent
set laststatus=2
set linespace=3
set splitbelow
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set mousehide
set showcmd
set foldenable
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{fugitive#statusline()}%y%=%-16(\ %l,%c-%v\ %)%P
set noerrorbells
set visualbell
set t_vb=

" ------------------------------------------------------------------------------
" MY leader key
" ------------------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

" ------------------------------------------------------------------------------
" wildignore settings
" ------------------------------------------------------------------------------
:set wildignore+=*.pyc

" ------------------------------------------------------------------------------
" Gui options
" ------------------------------------------------------------------------------
if has('gui_running')
    set go-=T
    set go+=LlRrb
    set go-=LlRrb
endif

" ------------------------------------------------------------------------------
" Source .vimrc when saved
" ------------------------------------------------------------------------------
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" ------------------------------------------------------------------------------
" Automatically change current directory to that of the file in the buffer
" ------------------------------------------------------------------------------
" autocmd BufEnter * cd %:p:h

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
nmap <leader>nt :NERDTreeToggle<cr>
nmap <leader>ev :tabedit $MYVIMRC<cr>

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
" Python autocomplete
" ------------------------------------------------------------------------------
autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" ------------------------------------------------------------------------------
" Command-T settings
" ------------------------------------------------------------------------------
nmap <leader>t :CommandT<cr>
let g:CommandTMaxFiles=5000

" ------------------------------------------------------------------------------
" NERDTree settings
" ------------------------------------------------------------------------------
let NERDTreeIgnore=['\.pyc']

" ------------------------------------------------------------------------------
" Pyflakes settings
" ------------------------------------------------------------------------------
let g:pyflakes_use_quickfix = 0

"
"
"
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" ------------------------------------------------------------------------------
" TaskList plugin
" ------------------------------------------------------------------------------
map <leader>td <Plug>TaskList

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
