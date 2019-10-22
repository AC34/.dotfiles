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


#linking manually
#vimrc
ln -sfn $DOT_HOME/dotfiles/.vimrc $HOME/.vimrc



#vim plug setup
if [ ! -f ~/.vim/autoload/plug.vim ]; then
 #force install curl first
 echo 
 echo "in order to have vim-plug installed. you'll need to have curl installed first."
 sudo apt install curl
 #then download vim-plug
 curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
fi

