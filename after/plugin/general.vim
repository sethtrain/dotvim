function WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction
map <leader>W :call WriteCreatingDirs()
