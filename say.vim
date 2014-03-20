function! s:FunnySay(saying)
    execute ':silent !say -v "Hysterical" ' . shellescape(escape(a:saying, "%#!")) . '&'
    execute ':redraw!'
endfunction

function! s:CSay(saying)
    execute ':silent !say -v "Whisper" ' . shellescape(escape(a:saying, "%#!")) . '&'
    execute ':redraw!'
endfunction

function! s:CowSay(saying)
    silent !clear
    let s = shellescape(escape(a:saying, "%#!"))
    execute '!cowsay ' . s . ' && say -v "Trinoids" ' . s
endfunction

command! -nargs=1 Say call s:FunnySay(<f-args>)
command! -nargs=1 CreepySay call s:CSay(<f-args>)
command! -nargs=1 CowSay call s:CowSay(<f-args>)
