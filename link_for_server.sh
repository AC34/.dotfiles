#!/usr/bin/env bash

#user check
if [ whoami = "root" ]; then
  echo "logged in as root, please login as a user"
	exit
fi

#initialize directory path
DOT_HOME="${HOME}/.dotfiles"

#make sure .dotfiles directory exists
if [ ! -d $DOT_HOME ]; then
  mkdir $DOT_HOME
fi

#bash alias update
echo "alias python=python3" >> $ALIAS
echo "alias pip=pip3" >> $ALIAS
echo "alias v=vim" >> $ALIAS
echo "alias ls='ls --color=never'" >> $ALIAS
echo "alias r='ranger'" >> $ALIAS

#vim
#vimrc
ln -sfn $DOT_HOME/dotfiles/.vimrc $HOME/.vimrc

#update bash_aliases
ALIAS="${HOME}/.bash_aliases"
#pytho is required for nvim derivatives
sudo apt -y install python3 python3-pip
pip install nvim 
#ctags is required for gutentags
sudo apt -y install universal-ctags

#vim plug setup
if [ ! -f $HOME/.vim/autoload/plug.vim ]; then
 #force install curl first
 echo 
 echo "in order to have vim-plug installed. you'll need to have curl installed first."
 sudo apt install curl
 #then download vim-plug
 curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
fi

