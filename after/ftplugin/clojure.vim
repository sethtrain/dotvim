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

map <leader>ras :!lein spec<cr>
map <leader>rs :call RunSingleFileSpec()<cr>
