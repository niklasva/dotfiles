# niklas home .bashrc

### EXPORT ###
# Lägg coreutils i PATH för GNU-versioner av program i OSX
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
# Förhindra java från att dyka upp i dock
#export JAVA_TOOL_OPTIONS="-Dapple.awt.UIElement=true"
export TF_NOTELEMETRY=true

# Infinite history
export HISTSIZE=""

export LANG="sv_SE.UTF-8"
export VPN="IMI VPN"

eval `dircolors -b $HOME/.dircolors`

### ALIAS ###
alias ls='ls -hN --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias chunk='chunkwm & skhd &'
alias undwm='pkill yabai skhd &'
alias vimrc='vi ~/.vimrc' 
alias bashrc='vi ~/.bashrc' 
alias dwm='yabai > /dev/null 2>&1 & skhd > /dev/null 2>&1 &'


### CMDS ###
source ~/.scripts


# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"

C_DEF="\[\e[m\]"
C_RED="\[\e[0;31m\]"
C_GREEN="\[\e[0;32m\]"
C_ORANGE="\[\e[0;33m\]"
C_BLUE="\[\e[0;34m\]"
C_PURPLE="\[\e[0;35m\]"
C_CYAN="\[\e[0;36m\]"
C_WHITE="\[\e[0;37m\]"
N_JOBS='`[ \j -gt 0 ] && echo " (\j)"`'

export PS1="$C_ORANGE\u$C_DEF@\h$C_RED:$C_GREEN\w $C_RED\$$C_DEF$C_PURPLE$N_JOBS$C_DEF "
