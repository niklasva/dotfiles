export TERM=xterm
. /opt/ess/etc/profile_std
. /home/josv/.scripts   # läs in svantes skript
. /home/niva/.scripts   # läs in mina skript (och skriv över dubletter)


function get_menuid
{
  if [ "$SUBSYSTEM" == "HOD" ] ;
    then
      echo ${MENUID,,}w
    else
      echo ${SUBSYSTEM,,}
  fi
}

C_DEF="\[\e[m\]"
C_RED="\[\e[0;31m\]"
C_GREEN="\[\e[0;32m\]"
C_ORANGE="\[\e[0;33m\]"
C_BLUE="\[\e[0;34m\]"
C_PURPLE="\[\e[0;35m\]"
C_CYAN="\[\e[0;36m\]"
C_WHITE="\[\e[0;37m\]"
N_JOBS='`[ \j -gt 0 ] && echo " (\j)"`'

export PS1="$C_ORANGE\u$C_DEF@\h$C_RED:$C_BLUE\$(get_menuid)$C_RED:$C_GREEN\w $C_RED\$$C_DEF$C_PURPLE$N_JOBS$C_DEF "

export VISUAL=vim
export EDITOR="$VISUAL"
export SRCDIR="$ZZZ_HOME/MASTER/menuidrel/NORMAL/src"
export APHEDI="/u/edi/std/aph/bin/"

export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

if [ -d "$HOME/.bin" ] ; then
  PATH="$HOME/.bin:$PATH"
fi

export notes="$HOME/notes"

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
alias bashrc='vim ~/.bashrc; source ~/.bashrc'
alias screenrc='vim ~/.screenrc'
alias vimrc='vim ~/.vimrc'
alias la='ls -a'
alias ll='ls -l'

alias sfquery_comp='sfquery -l TEST1 nnnnynnn'
alias sfquery_relnotes='sfquery -l TEST1 nnnnnyyy'
alias sfquery_package='cd /opt/ess/ehda/HOD/APH/TEST1/package'
alias aphpath='sfmisc -path'
alias aphput='cd /opt/ess/ehda/HOD/APH/TEST1/src'

alias nivagen='ehdagen -w -dLOG4T_LOG_LEVEL=LOG4T_ALL '

alias notes='vim $notes'

BASH_SESSION_ID=1
.  ~/.bash_dirs
load_dirs

mesg y

/home/niva/.motd/motd.sh

cheaphw
