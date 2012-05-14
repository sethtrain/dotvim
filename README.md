dotvim
======

Adding plugin bundle
--------------------

    $ git submodule add <git url> <local_path>
    $ git submodule add https://github.com/tpope/vim-fugitive.git bundle/fugitive

Setup
-----

    $ git clone https://github.com/sethtrain/dotvim.git .vim
    $ ln -s .vim/vimrc ~/.vimrc
    $ cd .vim
    $ git submodule init
    $ git submodule update
