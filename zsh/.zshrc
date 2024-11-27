un=$(uname -s)

# Mac OS

if [[ "$un" == "Darwin" ]]
then
    defaults write com.apple.finder CreateDesktop false
fi

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TMUX=tmux

## Oh My ZSH

export DISABLE_UPDATE_PROMPT=true

if [ -d "$HOME/.oh-my-zsh" ]
then
   export ZSH="$HOME/.oh-my-zsh"
   export ZSH_THEME="robbyrussell"

   plugins=(zsh-fzf-history-search)

   source $ZSH/oh-my-zsh.sh
else
    echo 'ZSH installation not found. To install, run install_omz'
fi

## ZSH ##

# VI mode
bindkey -v

# ZSH History
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

## Aliases ##

if command -v "exa" 1> /dev/null 2> /dev/null
then
	alias ls="exa"
	alias ll="exa -al"
else
	alias ll="ls -al"
fi

if command -v "lazygit" 1> /dev/null 2> /dev/null
then
	alias lg="lazygit"
fi

alias mkdir="mkdir -pv"

alias info="info --vi-keys"

alias e.="open ."
alias ..="cd .."

alias tmuxa="tmux attach || tmux"

if command -v "nvim" 1> /dev/null 2> /dev/null
then
	alias vim="nvim"
fi

## Environment ##

export EDITOR=vim

## Git ##

alias g="git"
alias gs="git status"
alias gb="git branch"
alias gl="git log -n 5"
alias greset="git reset --hard HEAD"

git config --global core.excludesfile ~/.gitignore

# Misc aliases

alias find-largest-files="du -a /dir/ | sort -n -r"

## Functions ##

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
	bash /tmp/.run.sh $func
    else
	echo "run.sh missing..."
	exit 1
    fi
}

backup() {
    if [ $# -eq 0 ]; then
        echo "Provide a filename"
        return 1
    fi

    local src_file="$1"
    local timestamp=$(date +"%Y-%m-%d_%T")
    local dst_file="${src_file}.bak.$timestamp"

    cp "$src_file" "$dst_file"
}

function pgrep() {
    pid=false

    if [ "$1" = "-p" ]
    then
	pid=true
	shift
    fi

    if [ -z "$1" ]
    then
	echo "Missing search query.\n\nSyntax: pgrep [-p] query\n\nFlags:\n\t-p: Only print pids"
	return
    fi

    search="$1"

    if [ "$pid" = false ]
    then
	ps aux | grep "$@" | grep -v grep | grep -v defunct
    else
	ps aux | grep "$@" | grep -v grep | grep -v defunct | awk '{ print $2; }'
    fi
}

function killall() {
    ps aux | grep "$@" | grep -v grep | grep -v defunct | awk '{ print $2; }' | xargs kill -9
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

## Fzf ##

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Python ##

[ -f "$HOME/.pythonrc" ] && export PYTHONSTARTUP="$HOME/.pythonrc"

if [ -d "$HOME/python-scripts" ]
then
    export PYTHONPATH="$HOME/python-scripts:$PYTHONPATH"
fi

# Machine-specific config
[ -f ~/.zshcustom ] && source ~/.zshcustom

