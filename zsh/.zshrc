## System

un=$(uname -s)

if [[ "$un" == "Darwin" ]]
then
	defaults write com.apple.finder CreateDesktop false
fi

## ZSH

# Oh my Zsh

if [ -d "$HOME/.oh-my-zsh" ]
then
	export ZSH="$HOME/.oh-my-zsh"
	ZSH_THEME="robbyrussell"
	plugins=(zsh-autosuggestions)
	# Preserve the order of this
	source $ZSH/oh-my-zsh.sh
fi

# ZSH History

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# VI mode
bindkey -v

## Aliases

# General

if command -v "exa" 1> /dev/null 2> /dev/null
then
	alias ls="exa"
	alias ll="exa -al"
else
	alias ll="ls -Al"
fi

alias mkdir="mkdir -pv"

alias info="info --vi-keys"

alias e.="open ."
alias ..="cd .."

# Git

alias g="git"
alias gs="git status"
alias gb="git branch"
alias gl="git log -n 5"
alias greset="git reset --hard HEAD"

git config --global core.excludesfile ~/.gitignore

# Python

if command -v "pip3" 1> /dev/null 2> /dev/null
then
	alias pip=pip3
fi

if command -v "python3" 1> /dev/null 2> /dev/null
then
	alias python=python3
fi

# Environment Variables

export EDITOR=vim

# Functions

function run() {
	if [[ -f "./run.sh" ]]
	then
		if [[ -n $1 ]]
		then
			func=$1
		else
			func="run"
		fi

		cp run.sh /tmp/.run.sh
		echo "\n\$@" >> /tmp/.run.sh
		sh /tmp/.run.sh $func
	else
		echo "run.sh missing..."
		exit 1
	fi
}

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

# Load machine-specific config

[ -f ~/.zshcustom ] && source ~/.zshcustom
