set -o vi

eval "$(/opt/homebrew/bin/brew shellenv)"
eval `gdircolors -b $HOME/.dircolors`
export BASH_SILENCE_DEPRECATION_WARNING=1
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export GOPATH=$HOME/.go
export HISTSIZE=""
export HOMEBREW_NO_ENV_HINTS=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export MANPATH="/usr/local/share/man:$MANPATH"
export PATH="/Applications/ARM/bin:$PATH"
export PATH="/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/usr/local/bin:/Users/niklas/Library/Python/3.8/bin:$PATH"
export PATH="/usr/local/opt/qt@5/bin:$PATH"
export PATH="~/.bin/mipsel-none-elf/bin:$PATH"
export PATH="~/.bin:/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="~/.go/bin:/Users/niklas/.cargo/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/qt@5/lib/pkgconfig"
export PYTHONPATH=/opt/homebrew/lib/python3.9/site-packages:/Users/niklas/Library/Python/3.8/lib/python/site-packages:$PYTHONPATH
source /opt/homebrew/etc/bash_completion.d/git-prompt.sh

# Folders to hide, unless ls -a is used
LS_HIDE_ARGS='--ignore=Desktop --ignore=Documents --ignore=Downloads --ignore=Library --ignore=Movies --ignore=Music --ignore=Pictures --ignore=Public'

alias chunk='chunkwm & skhd &'
alias cocot="cocot -p iso8859-1"
alias dwm='yabai > /dev/null 2>&1 & skhd > /dev/null 2>&1 &'
alias git-tf="~/dev/github/git-tf/git-tf"
alias grep="grep --color=always"
alias less="less -r"
alias ls='gls -hN --color=auto --group-directories-first $LS_HIDE_ARGS'
alias lsa='gls -hN --color=auto --group-directories-first'
alias luit="luit -encoding iso88591"
alias more="more -r"
alias newsboat="newsboat -q"
alias rss="newsboat"
alias ts="ts '[%Y-%m-%d %H:%M:%S]'"
alias undwm='pkill yabai skhd &'
alias vim=nvim

# Intel brew for x86 applications
alias ibrew="arch -x86_64 /usr/local/bin/brew"

# If shell is not opened from emacs, or if there already is a TMUX process, launch TMUX.
[ $TERM != "eterm-color" ] && [ $TERM != "eterm-256color" ] && [ -z "$TMUX"  ] && `tmux attach || tmux`

# Remember working directory from last session
if [[ -f ~/.bash_lastdir ]]; then
    source ~/.bash_lastdir
    cd $BASH_LAST_DIR
fi

BASE16_SHELL_PATH="$HOME/.config/base16-shell" && [ -n "$PS1" ] && [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && source "$BASE16_SHELL_PATH/profile_helper.sh"
C_DEF="\[\e[m\]"
C_RED="\[\e[0;31m\]"
C_GREEN="\[\e[0;32m\]"
C_ORANGE="\[\e[0;33m\]"
C_BLUE="\[\e[0;34m\]"
C_PURPLE="\[\e[0;35m\]"
C_CYAN="\[\e[0;36m\]"
C_WHITE="\[\e[0;37m\]"
N_JOBS='`[ \j -gt 0 ] && echo " (\j)"`'
export PROMPT_DIRTRIM=2
export PS1="$C_BLUE\u$C_DEF@\h$C_RED:$C_GREEN\w $C_RED\$$C_DEF$C_PURPLE$N_JOBS$C_DEF "

nas()
{
	NAS_MAC="c8:60:00:02:30:26"
	if [ "$1" == "off" ]; then
		ssh -t nas sudo shutdown -p now
		waituntil off nas && echo "System is down."
	elif [ "$1" == "on" ]; then
		wakeonlan $NAS_MAC
		waituntil on nas && echo "System is on."
	else
		ssh -o ConnectTimeout=180 nas
	fi
}

waituntil()
{
	STATUS=-255
	REQUESTED_STATUS=-1
	if [ "$1" == "off" ]; then
		REQUESTED_STATUS=2
	else
		REQUESTED_STATUS=0
	fi

	while [ $STATUS -ne $REQUESTED_STATUS ]; do
		sleep 5 && ping -c 1 -t 1 $2 > /dev/null
		STATUS=$?
	done
	return 0
}
