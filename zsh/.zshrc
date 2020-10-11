# ZSH CONFIG #

export ZSH="/Users/victorvelechosky/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git)

# Preserve order
source $ZSH/oh-my-zsh.sh

# ALIASES #

# Default command options
alias grep="grep -iE"
alias info="info --vi-keys"

# Git abbreviations
alias g="git"
alias gs="git status"
alias gb="git branch"
alias gc="git commit"
alias ga="git add"
alias gl="git log -n 5"

# Docker and run utils
alias run="sh ./Run.sh"
alias run-tf="docker run -u $(id -u):$(id -g) -it --rm tensorflow/tensorflow"
alias run-in-tf="docker run -u $(id -u):$(id -g) -it --rm tensorflow/tensorflow python -c \"$1\""

# Utility functions
killall() {
	ps aux | grep -i "$1" | grep -v grep | awk '{ print $2; }' | xargs kill -9
}


  # Set Spaceship ZSH as a prompt
  autoload -U promptinit; promptinit
  prompt spaceship
