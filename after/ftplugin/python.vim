setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
let b:ale_linters = {'python': ['flake8']}
autocmd FileType python let b:dispatch = 'nosetests --pdb --nocapture %'
