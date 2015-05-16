function! yuska#CurrentInfoClj()
  let word = expand("<cword>")
  let ns = fireplace#ns()
  let response = fireplace#evalparse("(cider.nrepl.middleware.info/info-clj '". ns . " '" . word . ")")
  echo response
endfunction

function! yuska#CurrentInfo()
  let response = fireplace#info(expand("<cword>"))

  if empty(get(response, 'file', [])) == 0
    let response.file = substitute(response.file, "/home/monolith", "/Users/seth", "")
    let response.file = substitute(response.file, "/app/monolith", "/Users/seth/projects/cicayda/monolith", "")
  endif

  return response
endfunction

function! yuska#CurrentArgs()
  let info = yuska#CurrentInfo()
  echo get(info, 'arglists-str')
endfunction

function! yuska#GotoDefinition()
  let info = yuska#CurrentInfo()
  if empty(get(info, 'file', [])) == 0
    let f = substitute(info.file, "file:", "", "")
    echom "yuska#GotoFile " . f
    exe "vsplit " . f
    exe "normal " . info.line . "Gzz"
  else
    echo "No file information from nREPL retrieved"
  endif
endfunction

function! yuska#FindUsages()
  let info = yuska#CurrentInfo()
  let response = fireplace#evalparse("(refactor-nrepl.find-symbol/find-symbol :ns '". info.ns . " :name \"" . info.name . "\")")

  echo response
endfunction

command! YuskaCurrentInfoClj call yuska#CurrentInfoClj()
command! YuskaCurrentInfo call yuska#CurrentInfo()
command! YuskaCurrentArgs call yuska#CurrentArgs()
command! YuskaGotoDefinition call yuska#GotoDefinition()
command! YuskaFindUsages call yuska#FindUsages()

map <leader>i :YuskaCurrentInfo<cr>
map <leader>K :YuskaCurrentArgs<cr>
map <leader>gd :YuskaGotoDefinition<cr>
map <leader>fu :YuskaFindUsages<cr>
