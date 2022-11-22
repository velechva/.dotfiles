## Aliases & Functions

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

# Processes

# Kill all processes matching a string
function killall() {
	ps aux | grep -i "$1" | grep -v grep | awk '{ print $2; }' | xargs kill -9
}

## Environment Variables

export EDITOR="vim"
export HISTORY_IGNORE="(pwd|ls|ll|clear|cd)"