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

   ZSH_THEME=robbyrussell

   plugins=(zsh-fzf-history-search)

   source $ZSH/oh-my-zsh.sh

   # Add hostname to prompt
   PROMPT="%m $PROMPT"
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
	alias ll="exa -alh"
else
	alias ll="ls -alh"
fi

if command -v "lazygit" &> /dev/null
then
	alias lg="lazygit"
fi

if command -v "lazydocker" &> /dev/null
then
	alias lzd="lazydocker"
fi

alias mkdir="mkdir -pv"

alias info="info --vi-keys"

alias e.="open ."
alias ..="cd .."

alias tmuxa="tmux -S ~/tmux attach || tmux -S ~/tmux"

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

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
[[ -d $PYENV_ROOT/bin ]] && eval "$(pyenv init - zsh)"

# Machine-specific config
[ -f ~/.zshcustom ] && source ~/.zshcustom
export PATH=$PATH:$HOME/cometlab-setup/scripts:$HOME/.local/bin/ # the cometlab-setup lab and lab-complete commands are here

# Always start in cometlab-setup
cd $HOME/cometlab-setup

# for pattern search (the wildcard `\*` will use zsh completion)
bindkey -v
bindkey "^R" history-incremental-pattern-search-backward

# allow shift-tab to move backwards for auto-completion
bindkey '^[[Z' reverse-menu-complete

# Auto-completion setup
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Load auto-completion for lab command and linode-compose
source .source/linode-compose.sh
source .source/lab.sh

# Git prompt
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'S' 
zstyle ':vcs_info:*' unstagedstr 'U' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats   '%F{5}[%F{2}%b%F{5}] %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] &&   [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
  hook_com[unstaged]+='%F{1}?%f'
fi
}
precmd () { vcs_info }
PROMPT='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_} %f%# '

# Highlighting for autocompletion menus, useful for the lab command especially
zstyle ':completion:*' menu select

# Store more history
HISTFILE=$HOME/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt SHARE_HISTORY

# Color LS output
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'

# Color ip output
alias ip="ip --color=auto"
