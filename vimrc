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
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" ------------------------------------------------------------------------------
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  " set guifont=Monaco:h14
  if has("gui_gtk2")
    set guifont=Inconsolata\ 15
  else
    set guifont=Inconsolata:h15
  end
endif

" ------------------------------------------------------------------------------
" Visual Settings
" ------------------------------------------------------------------------------
set t_Co=256
colorscheme grb256
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
set cursorline
set cmdheight=2

" ------------------------------------------------------------------------------
" Buffer commands
" ------------------------------------------------------------------------------
noremap <silent> ,bd :bd<CR>

" ------------------------------------------------------------------------------
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
" ------------------------------------------------------------------------------
"set winwidth=84
"set winheight=5
"set winminheight=5
"set winheight=999

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
" Map ,e and ,v to open files in the same directory as current file
" ------------------------------------------------------------------------------
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

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
" Various
" ------------------------------------------------------------------------------
map <leader>\dontstealmymapsmakegreen :w\|:call MakeGreen()<cr>

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
" Allow backspacing over everything in insert mode
" ------------------------------------------------------------------------------
set backspace=indent,eol,start

" ------------------------------------------------------------------------------
" Ack settings
" ------------------------------------------------------------------------------
nmap <leader>a <Esc>:Ack!

" ------------------------------------------------------------------------------
" Command-T settings
" ------------------------------------------------------------------------------
let g:CommandTMaxFiles=5000
nmap <leader>t :CommandT<cr>
" Open files with <leader>f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>

" ------------------------------------------------------------------------------
" Mini buffer explorer
" ------------------------------------------------------------------------------
let g:miniBufExplMaxSize = 2

" ------------------------------------------------------------------------------
" NERDTree settings
" ------------------------------------------------------------------------------
let NERDTreeIgnore=['\.pyc']

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
" Rope stuff
" ------------------------------------------------------------------------------
map <leader>rj :RopeGotoDefinition<CR>
map <leader>rr :RopeRename<CR>
map <leader>rev :RopeExtractVariable<CR>
map <leader>rd :RopeShowDoc<CR>
map <leader>rfo :RopeFindOccurances<CR>
map <leader>rai :RopeAutoImport<CR>
map <leader>rgac :RopeGenerateAutoimportCache<CR>

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

" ------------------------------------------------------------------------------
" Virtualenv stuff
" ------------------------------------------------------------------------------
" activate virtualenv in vim python
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

"load any vim customizations for the virtualenv
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
end
