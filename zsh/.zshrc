## ZSH

# Oh my Zsh

export ZSH="/Users/victorvelechosky/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(zsh-autosuggestions)
# Preserve the order of this
source $ZSH/oh-my-zsh.sh

# ZSH History

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

## Aliases

# General

alias ls="exa"
alias ll="exa -al"

alias info="info --vi-keys"
alias e.="open ."

alias ..="cd .."

# Git

alias g="git"
alias gs="git status"
alias gb="git branch"
alias gl="git log -n 5"
alias greset="git reset --hard HEAD"

# Run utils

alias run="sh ./run.sh"

# Python

alias pip=pip3
alias python=python3

# Environment Variables

export EDITOR=vim

# Functions

function killall() {
	ps aux | grep -i "$1" | grep -v grep | awk '{ print $2; }' | xargs kill -9
}

function devhints() {
	if [[ -z $1 ]]
	then
		open "https://devhints.io"
	elif [[ $1 == "--help" ]]
	then
		echo "Usage: devhints [<name>]"
		echo "Ex."
		echo "devhints bash"
	else
		open "https://devhints.io/$1"
	fi
}

# Fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Machine-specific

[ -f ~/.zshcustom ] && source ~/.zshcustom

