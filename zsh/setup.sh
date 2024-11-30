# Instructions!
#
# 1. Run from this directory
# 2. Execute `exit` the first time (after omz is done)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

rm ~/.zshrc
mv ~/.zshrc* ~/.zshrc

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

cd ..
./symlinks.sh

python3 ../setup.py neovim ripgrep lazygit rust-analyzer node pure

