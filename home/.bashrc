# niklas home .bashrc

### EXPORT ###
# Lägg coreutils i PATH för GNU-versioner av program i OSX
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
# Förhindra java från att dyka upp i dock
#export JAVA_TOOL_OPTIONS="-Dapple.awt.UIElement=true"
export TF_NOTELEMETRY=true

# Infinite history
export HISTSIZE=""
export PS1='$(whoami)@$(hostname):\w \[\e[0;31m\]$\[\e[m\] '
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
