function! RunSingleFileSpec()
  let current_file = expand("%")
  let test_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  if in_spec
      test_file = current_file
  else
      let test_file = substitute(test_file, '^src/', 'spec/', '')
      let test_file = substitute(test_file, '\.clj', '_spec.clj', '')
  endif
  exec ':!lein spec ' . test_file
endfunction

map <leader>ras :!lein spec<cr>
map <leader>rs :call RunSingleFileSpec()<cr>

function! OpenSpecAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1

  if in_spec
      let new_file = substitute(new_file, '^spec/', 'src/', '')
      let new_file = substitute(new_file, '_spec\.clj', '.clj', '')
  else
      let new_file = substitute(new_file, '^src/', 'spec/', '')
      let new_file = substitute(new_file, '\.clj', '_spec.clj', '')
  endif

  return new_file
endfunction

nnoremap <leader>. :call OpenSpecAlternate()<cr>
