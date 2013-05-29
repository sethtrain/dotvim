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
colorscheme Tomorrow-Night
" ------------------------------------------------------------------------------
" General Settings
" ------------------------------------------------------------------------------
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
set showtabline=2
" ------------------------------------------------------------------------------
" Enable Rainbow parenthesis
" ------------------------------------------------------------------------------
set shiftwidth=4
set expandtab
set nocompatible
set mousehide
set showcmd
set foldenable
set foldcolumn=3
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set statusline+=%{fugitive#statusline()}
set noerrorbells
set t_vb=
set cmdheight=1
set listchars=tab:▸\ ,eol:¬

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

if has('mouse')
    set mouse=nv
endif

" ------------------------------------------------------------------------------
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" ------------------------------------------------------------------------------
" ------------------------------------------------------------------------------
" Gui options
" ------------------------------------------------------------------------------
if &t_Co > 2 || has("gui_running")
  syntax on
  if has("gui_gtk2")
     set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 12
  elseif has("gui_macvim")
     set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12
  end
  "set go-=T
  set go-=l
  set go-=L
  set go-=r
  set go-=R
  set go-=m
  highlight iCursor guifg=white guibg=#0087af
  set guicursor=n-c:block-Cursor-blinkon0
  set guicursor+=v:block-vCursor-blinkon0
  set guicursor+=i-ci:ver20-iCursor
endif



" ------------------------------------------------------------------------------
" MY leader key
" ------------------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

" ------------------------------------------------------------------------------
" wildignore settings
" ------------------------------------------------------------------------------
set wildignore+=out,.lein-cljsbuild-compiler*,resources/*,*.pyc,target,node_modules,repl,uploads

" ------------------------------------------------------------------------------
" Source .vimrc when saved
" ------------------------------------------------------------------------------
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

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
nmap <leader>ev :tabe $MYVIMRC<cr>

" ------------------------------------------------------------------------------
" Allow backspacing over everything in insert mode
" ------------------------------------------------------------------------------
set backspace=indent,eol,start

" ------------------------------------------------------------------------------
" Enable Rainbow parenthesis
" ------------------------------------------------------------------------------

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ------------------------------------------------------------------------------
" Handle hlsearch better
" ------------------------------------------------------------------------------
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" ------------------------------------------------------------------------------
" Map ,e to open files in the same directory as current file
" ------------------------------------------------------------------------------
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>te :tabe %%

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
" General Bindings and plugin options
" ------------------------------------------------------------------------------

" Set toggle for Paste Mode
set pastetoggle=<F4>

map <leader>nt :NERDTreeToggle<cr>

" Format Entire File
map <leader>fef gg=G<cr>``zz

map <leader>cd :cd %%
map <leader>l :set list!<cr>

" convert horizontally split windows to vertically split
map <leader>htv <C-W>t<C-W>H

" buffer delete
noremap <silent> <leader>bd :bd<CR>

" Ack
nmap <leader>a <Esc>:Ack!

" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = ''
map <leader>t :CtrlP<cr>
map <leader>b :CtrlPBuffer<cr>

" Tabs
map <C-t> :tabnew<cr>
map <leader>tp :tabp<cr>
map <leader>tn :tabn<cr>
map <leader>tc :tabclose<cr>

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

" Gist
let g:gist_show_privates = 1
map <leader>gb :Gist -p<cr>
map <leader>gbs :Gist -p -m<cr>

" Gundo
map <leader>gt :GundoToggle<cr>

" Rainbow parentheses
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

" Clojure
map <leader>r :Require!<cr>
map <leader>rt :!lein test<cr>

" ------------------------------------------------------------------------------
" Tagbar
" ------------------------------------------------------------------------------
nmap <F8> :TagbarToggle<CR>

" GUI Tab label full path
function! GuiTabLabeler()
  let tabno = tabpagenr()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '[+]'
      break
    endif
  endfor

  " Append the number of windows in the tab page if more than one
  let wincount = tabpagewinnr(v:lnum, '$')
  if wincount > 1
    let label .= ' [' . wincount . ']'
  endif

  " Append the buffer name
  return tabno . " " .
         \ fnamemodify(bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]), ":t")
         \ . label
endfunction

set guitablabel=%!GuiTabLabeler()
