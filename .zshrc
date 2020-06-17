## OH MY ZSH

export ZSH="/Users/victorvelechosky/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

## USER CONFIG

# Path
export PATH=/Users/victorvelechosky/Library/Python/3.7/bin:/Users/victorvelechosky/.cargo/bin:$PATH

# Aliases

alias git="noglob git"
alias tmux="tmux source-file ~/.tmux.conf"
alias saveconf="cd ~/.dotfiles ; cp ~/.zshrc . ; cp ~/.tmux.conf . ; git add * ; git commit -m \"Config\" ; git push ; cd ~"
alias loadconf="cd ~/.dotfiles ; git reset --hard HEAD ; git pull ; cp .zshrc ~/.zshrc ; cp .tmux.conf ~/.tmux.conf ; cd ~"