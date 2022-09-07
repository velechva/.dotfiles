## General

# Oh my Zsh

export ZSH="/Users/victorvelechosky/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(zsh-autosuggestions)

# Spaceship prompt

autoload -U promptinit; promptinit
prompt spaceship

# Preserve the order of this
source $ZSH/oh-my-zsh.sh

## Aliases

# General

alias ll="ls -al"
alias info="info --vi-keys"

# Python

alias python=python3
alias pip=pip3

# Git

alias gs="git status"
alias gb="git branch"
alias gl="git log -n 5"
alias greset="git reset --hard HEAD"

# Run utils

alias run="sh ./run.sh"
alias build="sh ./build.sh"

## Environment Variables

export PATH=/Applications/CLion.app/Contents/bin/cmake/mac/bin:/usr/local/ghc/bin/:/Users/victorvelechosky/.emacs.d/bin:$PATH
export RACK_DIR=/usr/local/lib/rack-sdk-1.1.6
export PYTHONSTARTUP=/Users/victorvelechosky/.pythonrc
export EDITOR=vim

## Functions

function killall() {
	ps aux | grep -i "$1" | grep -v grep | awk '{ print $2; }' | xargs kill -9
}
