## Powerlevel10k instant prompt

# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

## System

un=$(uname -s)

# Mac OS

if [[ "$un" == "Darwin" ]]
then
	defaults write com.apple.finder CreateDesktop false
fi

export LANG=C.UTF-8
export LC_CTYPE=en_US.UTF-8
export TMUX=hello

## Oh My ZSH

if [ -d "$HOME/.oh-my-zsh" ]
then
       export ZSH="$HOME/.oh-my-zsh"
	   export ZSH_THEME="spaceship"
       plugins=(zsh-fzf-history-search)
       source $ZSH/oh-my-zsh.sh

		## Powerline10k
	    # source ~/powerlevel10k/powerlevel10k.zsh-theme
		# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
	    # typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
else
	echo '
ZSH installation not found. To install, run these commands:

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
rm ~/.zshrc
mv ~/.zshrc* ~/.zshrc
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
'
fi

## Spaceship Prompt

# export SPACESHIP_RUST_SHOW=false
# export SPACESHIP_PACKAGE_SHOW=false

## ZSH History

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

## VI mode
bindkey -v

## General Aliases

if command -v "exa" 1> /dev/null 2> /dev/null
then
	alias ls="exa"
	alias ll="exa -al"
else
	alias ll="ls -al"
fi

alias mkdir="mkdir -pv"

alias info="info --vi-keys"

alias e.="open ."
alias ..="cd .."

## Git

alias g="git"
alias gs="git status"
alias gb="git branch"
alias gl="git log -n 5"
alias greset="git reset --hard HEAD"

git config --global core.excludesfile ~/.gitignore

## Environment Variables

export EDITOR=vim

## Functions

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
	ps aux | grep -i "$1" | grep -v grep | grep -v defunct | awk '{ print $2; }'
}

function killall() {
	ps aux | grep -i "$1" | grep -v grep | grep -v defunct | awk '{ print $2; }' | xargs kill -9
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

## Fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Python

[ -f "$HOME/.pythonrc" ] && export PYTHONSTARTUP="$HOME/.pythonrc"

## Machine-specific config

if [ -d "$HOME/python-scripts" ]
then
	export PYTHONPATH="$HOME/python-scripts:$PYTHONPATH"
fi

[ -f ~/.zshcustom ] && source ~/.zshcustom

