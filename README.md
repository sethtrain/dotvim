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

Command-T
---------

    $ cd ~/.vim/bundle/command-t
    $ rake make

Inconsolata font
----------------

This is my programming font.  Inconsolata is licensed under the [SIL Open Font License, version 1.1](http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL).
