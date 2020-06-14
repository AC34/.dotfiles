

#in order to get this work, run "source .bashrc"


#vim
alias vim=nvim
alias v=nvim
alias vi=nvim

#common
alias python=python3
alias pip=pip3
alias sudo='sudo '
#suppress directory highlihght of ls
alias ls='ls --color=never'

alias vm='virtualbox'

alias r='ranger'
alias ls='ls -a'
alias ll='ls -la'

#firefox
#if [ "$XDG_SESSION_TYPE" = "x11" ]; then
#  alias f="firefox"
#  alias fp="firefox -private-window"
#else if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
#  if [ "$(command -v firefox-wayland)" != "" ]; then
#    alias f="firefox-wayland"
#    alias fp="firefox-wayland -private-window"
#  else
#    alias f="firefox"
#    alias fp="firefox -private-window"
#  fi
#fi

#chrome
if [ "$(command -v google-chrome)" != "" ]; then
  alias gc="google-chrome"
  alias gci="google-chrome -incognito"
fi

#chromium
if [ "$(command -v chromium)" != "" ]; then
  alias c=chromium
  alias ci=chromium -incoognito
fi

#libre-office
alias calc="libreoffice --calc"
alias writer="libreoffice --writer" 
alias impress="libreoffice --impress"
alias draw="libreoffice --draw"
alias math="libreoffice --math"

#git
alias gaa="git add --all"
alias gcam="git commit -am"
alias gp="git push"


