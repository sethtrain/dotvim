" Based on ir_black.vim
" Customized version of Gary Bernhardt's grb256.vim

runtime colors/ir_black.vim

let g:colors_name = "sethtrain"

hi Comment ctermfg=darkgrey
hi Normal         guifg=#f6f3e8     guibg=black       gui=NONE      ctermfg=NONE     ctermbg=NONE        cterm=NONE
hi StatusLine     ctermbg=darkgrey  ctermfg=white
hi StatusLineNC   ctermbg=234       ctermfg=lightgrey
hi VertSplit      ctermbg=NONE      ctermfg=lightgrey
hi LineNr         ctermfg=darkgrey
hi CursorLine     guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE     ctermbg=234
hi Function       guifg=#FFD2A7     guibg=NONE        gui=NONE      ctermfg=yellow   ctermbg=NONE        cterm=NONE
hi Visual         guifg=NONE        guibg=#262D51     gui=NONE      ctermfg=NONE     ctermbg=236         cterm=NONE
hi Error          guifg=NONE        guibg=NONE        gui=undercurl ctermfg=16       ctermbg=red         cterm=NONE     guisp=#FF6C60 " undercurl color
hi ErrorMsg       guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=16       ctermbg=red         cterm=NONE
hi WarningMsg     guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=16       ctermbg=red         cterm=NONE
hi SpellBad       guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=16       ctermbg=160         cterm=NONE

" Search highlight
hi Search         guifg=NONE        guibg=NONE        gui=NONE      ctermfg=black       ctermbg=3        cterm=NONE

" ir_black doesn't highlight operators for some reason
hi Operator       guifg=#6699CC     guibg=NONE        gui=NONE      ctermfg=lightblue   ctermbg=NONE     cterm=NONE

hi DiffAdd term=reverse cterm=bold ctermbg=lightgreen ctermfg=16
hi DiffChange term=reverse cterm=bold ctermbg=lightblue ctermfg=16
hi DiffText term=reverse cterm=bold ctermbg=lightgray ctermfg=16
hi DiffDelete term=reverse cterm=bold ctermbg=lightred ctermfg=16

hi PmenuSel ctermfg=16 ctermbg=156

hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=darkgrey
