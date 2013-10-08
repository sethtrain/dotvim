let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let', '^describe', '^it', '^around']

function! RunSingleFileSpec()
  let current_file = expand("%")
  let test_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  if in_spec
      let test_file = current_file
  else
      let test_file = substitute(test_file, '^src/', 'spec/', '')
      let test_file = substitute(test_file, '\.clj', '_spec.clj', '')
  endif
  exec ':!lein spec ' . test_file
endfunction

" Clojure
" map <leader>r :Require<cr>
map <leader>rt :!lein test<cr>
map <leader>ras :!lein spec<cr>
map <leader>rs :call RunSingleFileSpec()<cr>

" Setup clojurescript make and error formatting for phantomjs
au filetype clojure setlocal makeprg=phantomjs\ resources/private/js/runner.js\ resources/private/test.html
au filetype clojure setlocal errorformat=Test\ Failed:\ %m
" rq = run qunit
map <leader>rq :MakeGreen<cr>
