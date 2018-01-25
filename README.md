vim
====

Dependencies
------------

    $ brew install fzf

Setup
-----

    $ git clone https://github.com/sethtrain/doctvim.git ~/.vim
    $ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    $ vim +PluginInstall +qall
