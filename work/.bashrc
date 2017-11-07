. /opt/ess/etc/profile_std
. /home/niva/.scripts
export TERM=xterm
export PS1='$(whoami)@$(hostname):$MENUID:$(pwd)$ '
export VISUAL=vi
export EDITOR="$VISUAL"
export SRCDIR="$ZZZ_HOME/MASTER/menuidrel/NORMAL/src"

export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

set -o emacs

eval `dircolors -b $HOME/.dircolors`

alias ack="~/.ack --color"
alias more="more -v"
alias ls='/usr/linux/bin/ls --color --group-directories-first'
alias rmi='rm -i'
