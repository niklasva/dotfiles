# Path to your oh-my-zsh installation.
export ZSH=/Users/niklas/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_THEME="hotdog"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13
# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

 plugins=(git)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh



# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export TERM=xterm-256color
export EDITOR='vim'

PATH="/Users/niklas/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/niklas/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/niklas/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/niklas/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/niklas/perl5"; export PERL_MM_OPT;
ZLE_PROMPT_INDENT=0

alias ls='ls --color --group-directories-first'
eval "$(gdircolors ~/.dircolors)"


PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# Alias för gameboy debugger bgb
alias bgb='wine ~/bgb/bgb.exe'

# Alias för frotz (och zork)
alias frotz='./frotz/frotz'
alias zork='frotz ~/frotz/spel/zork1.z5'

# Alias för mame64
alias mame64='/Applications/mame/mame64'
alias mamedbg='/Applications/mame/mame64 -window -debug'

alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias tmux='tmux -u'
