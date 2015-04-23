" ------------------------------------------------------------------------------
" VUNDLE
" ------------------------------------------------------------------------------
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle (required)!
Bundle 'gmarik/vundle'

" Bundles
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bkad/CamelCaseMotion'
Bundle 'chase/vim-ansible-yaml'
Bundle 'ervandew/supertab'
Bundle 'gregsexton/gitv'
Bundle 'groenewege/vim-less'
Bundle 'itchyny/lightline.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/emmet-vim'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'mxw/vim-jsx'
Bundle 'nanotech/jellybeans.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/paredit.vim'
Bundle 'whatyouhide/vim-gotham'

filetype plugin indent on

" ------------------------------------------------------------------------------
" VISUAL SETTINGS
" ------------------------------------------------------------------------------
colorscheme gotham256
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
set encoding=utf-8
set t_Co=256
set term=xterm-256color
set termencoding=utf-8
set t_ut=

if has("gui_running")
   colorscheme gotham
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Droid\ Sans\ Mono\ for\ Powerline:h14
   endif
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
set t_vb=
set tabstop=4
set undodir=~/.vim/undo
set wildmode=list:longest
set noshowmode

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
" BUFFERLINE
" ------------------------------------------------------------------------------
let g:bufferline_echo = 0

" ------------------------------------------------------------------------------
" LIGHTLINE
" ------------------------------------------------------------------------------

let g:lightline = {
      \ 'colorscheme': 'gotham256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], [ 'ctrlpmark' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ }
      \ }

" ------------------------------------------------------------------------------
" Remove (or add):
"  \ 'separator': { 'left': '⮀', 'right': '⮂' },
"  \ 'subseparator': { 'left': '⮁', 'right': '⮃' },
"
" to remove/insert arrows next to mode names
" ------------------------------------------------------------------------------

let g:lightline.mode_map = {
            \ 'n'      : ' N ',
            \ 'i'      : ' I ',
            \ 'R'      : ' R ',
            \ 'v'      : ' V ',
            \ 'V'      : 'V-L',
            \ 'c'      : ' C ',
            \ "\<C-v>" : 'V-B',
            \ 's'      : ' S ',
            \ 'S'      : 'S-L',
            \ "\<C-s>" : 'S-B',
            \ '?'      : '      ' }

function! MyModified()
    let map = { 'V': 'n', "\<C-v>": 'n', 's': 'n', 'v': 'n', "\<C-s>": 'n', 'c': 'n', 'R': 'n'}
    let mode = get(map, mode()[0], mode()[0])
    let bgcolor = {'n': [240, '#585858'], 'i': [31, '#0087af']}
    let color = get(bgcolor, mode, bgcolor.n)
    exe printf('hi ModifiedColor ctermfg=196 ctermbg=%d guifg=#ff0000 guibg=%s term=bold cterm=bold',
                \ color[0], color[1])
    return &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

" ------------------------------------------------------------------------------
" vim-jsx
" ------------------------------------------------------------------------------
let g:jsx_ext_required = 0

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

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>cd :cd %%
map <leader>e :edit %%
map <leader>te :tabe %%
nnoremap <F4> :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <leader>B :CtrlPBuffer<cr>
nnoremap <leader>G :Gist<cr>
nnoremap <leader>R :Require<cr>
nnoremap <leader>a <Esc>:Ag!
nnoremap <leader>cn :tabe ~/Dropbox/Notes/coding-notes.md<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>fef gg=G<cr>``zz
nnoremap <leader>ff [[v%==
nnoremap <leader>gc :Gcommit -m ""<left>
nnoremap <leader>gca :Gcommit -m -a ""<left>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>h <C-w>s<C-w>j
nnoremap <leader>htv <C-W>t<C-W>H
nnoremap <leader>l :set list!<cr>
nnoremap <leader>m :make %<cr>
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>pc <Esc>:Pytest class<CR>
nnoremap <leader>pf <Esc>:Pytest file<CR>
nnoremap <leader>pm <Esc>:Pytest method<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>v <C-w>v<C-w>l
nnoremap gN :bprevious<CR>
nnoremap gd :bdelete<CR>
nnoremap gf <C-^>
nnoremap gn :bnext<CR>

