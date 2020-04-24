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

set -o vi
bind -m vi-insert "\C-l":clear-screen
bind -m vi-insert "^?":backward-delete-char
bind -m vi-insert "\C-p":previous-history
bind -m vi-insert "\C-n":next-history

eval `dircolors -b $HOME/.dircolors`

alias ack="~/.ack --color"
alias more="more -v"
alias ls='/usr/linux/bin/ls --color --group-directories-first'
alias rmi='rm -i'
alias screen=screen-color
alias vi=vim
alias cd..='cd ..'
alias dunnet='emacs -batch -l dunnet'
alias ltr='ls -ltr'
alias bashrc='vim ~/.bashrc'
alias screenrc='vim ~/.screenrc'
alias vimrc='vim ~/.vimrc'

alias sfquery_comp='sfquery -l TEST1 nnnnynnn'
alias sfquery_relnotes='sfquery -l TEST1 nnnnnyyy'
alias sfquery_package='cd /opt/ess/ehda/HOD/APH/TEST1/package'
alias aphpath='sfmisc -path'
alias aphput='cd /opt/ess/ehda/HOD/APH/TEST1/src'

#"if [ -z "$STY" ];
#then
#  screen -dR;
#else
#  TERM="xterm"
#fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"

