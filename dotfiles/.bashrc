
#no duplicated gistory
HISTCONTROL=ignoreboth
#setting history length
HISTSIZE=1000
HISTFILESIZE=2000

#check the window size after each command and, if necssary,
#update the values of lines and columns
#for the auto folding
shopt -s checkwinsize

#set ignoreeof to 100
#so doe not automatically logout with ctrl-d(mistakenly)
export IGNOREEOF=100

#PS1 setting
PS1="[\u@\h \W]"

#load the aliases
. ~/.bash_aliases

#laod bash completion
if [ $(command -v bash-completion) ]; then
  if [ -f $BCPATH ]; then
    $(bash-completion)
  fi
fi

#editing mode to vi
set editing-mode vi
set -o vi

#inreasing key repeat speed
xset r rate 200 60

#powerline
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
if [ -f 'which powerline-daemon' ]; then
  powerline-daemon -q
  . /usr/share/powerline/bash/powerline.sh
fi

#ranger variables
export VISUAL=nvim
export EDITOR=nvim



