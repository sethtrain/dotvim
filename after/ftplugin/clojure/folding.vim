function! ClojureFolds(lnum)
    let l1 = getline(a:lnum)

    if l1 =~ '^\s*$'
        " ignore empty lines
        return '='
    elseif l1 =~ '^(defn\+s*'
        return '>1'
    elseif l1 =~ '^(deftopic\+s*'
        return '>1'
    else
        return "="
    endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=ClojureFolds(v:lnum)
setlocal nofoldenable
