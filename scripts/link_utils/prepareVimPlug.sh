#!/usr/bin/env bash


function prepareVimPlug(){
  if [ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
	  #ask for installation
    echo "Install vim-plug?"
		read -p "(y/n)" yn
		if [[ $yn = [yY] ]]; then
			echo "installing vim-plug"
      sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		fi
  else
    echo vim-plug is already installed
  fi
}

