set un (uname -s)

if status is-interactive
		if [ "$un" = "Darwin" ]
			defaults write com.apple.finder CreateDesktop false
		end

		export LANG=C.UTF-8

		fish_vi_key_bindings --no-erase

		alias ll="ls -al"
		alias mkdir="mkdir -pv"
		alias info="info --vi-keys"

		if type -q lazygit
			alias lg="lazygit"
		end

		if type -q lazydocker
			alias lzd="lazydocker"
		end

		if type -q exa
			alias ls="exa"
			alias ll="exa -al"
		else
			alias ll="ls -al"
		end

		alias mkdir="mkdir -pv"
		alias info="info --vi-keys"

		alias e.="open ."
		alias ..="cd .."

		alias g="git"
		alias gs="git status"
		alias gb="git branch"
		alias gl="git log -n 5"
		alias greset="git reset --hard HEAD"

		alias find-largest-files="du -a /dir/ | sort -n -r"

		git config --global core.excludesfile ~/.gitignore

		if type -q nvim
			set -g EDITOR "nvim"
			alias vim="nvim"
		end

		function killall
			ps aux | grep -i "$1" | grep -v grep | grep -v defunct | awk '{ print $2; }' | xargs kill -9
		end

		function pgrep
				ps aux | grep -i "$1" | grep -v grep | grep -v defunct | awk '{ print $2; }'
		end

		if test -f "$HOME/.pythonrc"
			export PYTHONSTARTUP="$HOME/.pythonrc"
		end

		bind --user -M insert \cr history-pager

		alias tmuxa="tmux -S ~/tmux attach || tmux -S ~/tmux"

		zoxide init fish | source

		export EDITOR=vim
end

if [ "$un" = "Darwin" ]
		fish_add_path -P /opt/homebrew/bin
end

if test -f "$HOME/.config/fish/custom.fish"
	source "$HOME/.config/fish/custom.fish"
end

