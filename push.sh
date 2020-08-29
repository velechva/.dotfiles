cd ~/.dotfiles
cp ../.zshrc zsh/.zshrc
cp ../.tmux.conf tmux/.tmux.conf
git add zsh/.zshrc tmux/.tmux.conf
git commit -m "Update"
git push
