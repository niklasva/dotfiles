. /opt/ess/etc/profile_std
. /home/niva/.scripts
export TERM=xterm
export PS1='$(whoami)@$(hostname):$MENUID:$(pwd) \[\e[0;31m\]$\[\e[m\] '
export VISUAL=vim
export EDITOR="$VISUAL"
export SRCDIR="$ZZZ_HOME/MASTER/menuidrel/NORMAL/src"
export APHEDI="/u/edi/std/aph/bin/"

export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
export MANDIR=/home/niva/.bin/man|$MANDIR

PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

if [ -d "$HOME/.bin" ] ; then
  PATH="$HOME/.bin:$PATH"
fi

set -o emacs

eval `dircolors -b $HOME/.dircolors`

alias ack="~/.ack --color"
alias more="more -v"
alias ls='/usr/linux/bin/ls --color --group-directories-first'
alias rmi='rm -i'
alias screen=screen-4.6.2
alias vi=vim
alias cd..='cd ..'
