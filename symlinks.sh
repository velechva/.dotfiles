rm ~/.zshrc 2> /dev/null
ln -s "$(pwd)/zsh/.zshrc" ~/.zshrc

rm ~/.pythonrc 2> /dev/null
ln -s "$(pwd)/python/.pythonrc" ~/.pythonrc

rm ~/.tmux.conf 2> /dev/null
ln -s "$(pwd)/tmux/.tmux.conf" ~/.tmux.conf

rm ~/.vimrc 2> /dev/null
ln -s "$(pwd)/vim/.vimrc" ~/.vimrc

rm ~/.alacritty.toml 2> /dev/null
ln -s "$(pwd)/alacritty/.alacritty.toml" ~/.alacritty.toml

rm ~/.config/fish/config.fish 2> /dev/null
ln -s "$(pwd)/fish/config.fish" ~/.config/fish/config.fish

