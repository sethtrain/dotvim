vim
====

Dependencies
------------

    $ brew install fzf

Setup
-----

    $ git clone https://github.com/sethtrain/dotvim.git ~/.vim
    $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    $ vim +PluginInstall +qall
    $ CocInstall coc-python

Configuration (Python)
----------------------

    :CocInstall coc-python

Once you've installed all the plugins above you will need to configure your Python envrionment.
Below is a sample `.vim/coc-settings.json`:

```
{
  "python.linting.pylintEnabled": false,
  "python.linting.flake8Enabled": true,
  "python.linting.enabled": true,
  "python.jediEnabled": false
}
```

You should also configure your interpreter:

```
:CocCommand<cr>
python.setInterpreter
```

Configuration (Ruby)
----------------------

The use of `solargraph` assumes:

    $ gem install solargraph

Once the gem is installed you can proceed with the vim configuration.

    :CocInstall coc-solargraph

For new projects you should generate a `solargraph` config file:

    :CocCommand solargraph.config

