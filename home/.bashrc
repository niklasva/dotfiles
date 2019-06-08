# niklas home .bashrc

### EXPORT ###
  # Lägg coreutils i PATH för GNU-versioner av program i OSX
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"

  # Infinite history
  export HISTSIZE=""
  export PS1='$(whoami)@$(hostname):\w \[\e[0;31m\]$\[\e[m\] '
  export LANG="sv_SE.UTF-8"
  export VPN="IMI VPN"

### ALIAS ###
  alias ls='ls -hN --color=auto --group-directories-first'
  alias grep='grep --color=auto'

### CMDS ###
  source ~/.scripts
