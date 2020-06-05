
#setting history length
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# the auto foldding
shopt -s checkwinsize

#set ignoreeof to 100
#so does not end with ctrl-d
export IGNOREEOR=100

#$PS1 setting
PS1="[\u@\h \W]"

#source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# load the aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

#load bash completion
BCPATH=$(whereis bash-completion)
BCPATH=${BCPATH/bash-completion: /}
if [ -f $BCPATH ]; then
  $(BCPATH)
fi

#editing mode to vi
set editing-mode vi
set -o vi

#key repeat speed
xset r rate 200 60

#powerline
#if [ -f 'which powerline-daemon' ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
#fi

#this variable is read from ranger
export VISUAL=nvim;
export EDITOR=nvim;


