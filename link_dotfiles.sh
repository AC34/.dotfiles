#!/usr/bin/env bash


#user check
if [ whoami = "root" ]; then
  echo "logged in as root, please login as a user"
else
  #initialize directory path
  $DOT_HOME="${HOME}/.dotfiles/dotfiles"
fi

#prepare directory
if [ -d ~/.dotfiles ]; then
  mkdir ~/.dotfiles
fi

#clone git repo
cd $DOT_HOME
git clone git@github.com:AC34/dotfiles.git









