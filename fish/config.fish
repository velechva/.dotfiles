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

		alias g="git"
		alias gs="git status"
		alias greset="git reset --hard HEAD"

		git config --global core.excludesfile ~/.gitignore

		export EDITOR "nvim"

		function killall
			ps aux | grep -i "$1" | grep -v grep | grep -v defunct | awk '{ print $2; }' | xargs kill -9
		end

		function pgrep
				ps aux | grep -i "$1" | grep -v grep | grep -v defunct | awk '{ print $2; }'
		end

		if test -f "$HOME/.pythonrc"
			export PYTHONSTARTUP="$HOME/.pythonrc"
		end
end

if [ "$un" = "Darwin" ]
		fish_add_path -P /opt/homebrew/bin
end

if test -f "$HOME/.config/fish/custom.fish"
	source "$HOME/.config/fish/custom.fish"
end

