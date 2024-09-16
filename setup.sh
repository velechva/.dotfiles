set -e

un=$(uname -s)

read -p "Install oh-my-zsh? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
fi

read -p "Install tpm? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

read -p "Install fzf? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

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

read -p "Install ripgrep?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [[ "$un" == "Darwin" ]]
    then
	brew install ripgrep
    fi

    if [[ "$un" == "Linux" ]]
    then
	sudo apt-get install -y ripgrep
    fi
fi

read -p "Install neovim?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [[ "$un" == "Darwin" ]]
    then
	brew install neovim
    fi

    if [[ "$un" == "Linux" ]]
    then
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo rm -rf /opt/nvim
	sudo tar -C /opt -xzf nvim-linux64.tar.gz
	echo "export PATH=\"$PATH:/opt/nvim-linux64/bin\"" >> ~/.zshcustom
    fi
fi

read -p "Install neovim?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    wget https://nodejs.org/dist/v20.17.0/node-v20.17.0-darwin-x64.tar.gz
    tar -xzf node-v20.17.0-darwin-x64.tar.gz
    mv node-v20.17.0-darwin-x64.tar.gz /opt
    echo "export PATH=\"$PATH:/opt/node-v20.17.0-darwin-x64.tar.gz/bin\"" >> ~/.zshcustom
fi
