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

Incosonata (the font used in my vimrc file) is freely available under the [Open Font License](http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=OFL&_sc=1). [The OpenType version](http://www.levien.com/type/myfonts/Inconsolata.otf) of Inconsolata will work on all major platforms. There is also a [PFA version](http://www.levien.com/type/myfonts/Inconsolata.pfa) available.
