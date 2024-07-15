set -e

# Install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

read -p "Install symlinks? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ./symlinks.sh
fi

read -p "Set DOTFILESPATH in .zshcustom?? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "export DOTFILESPATH=$(pwd)" >> ~/.zhscustom
fi
