#!/usr/bin/env bash

#installs on the .dotfiles directory(not the actual .config~ dir)

function prepareVimPlug(){
  if [ -z "$1" ];then
	  echo "prepareVimPlug: argument 1 missing"
	  exit
  fi
  DOT_HOME=$1
  PLUG_DIR="$DOT_HOME/config/nvim/autoload"
  echo "preparvimplug dothomoe:$DOT_HOME"
  if [ ! -f "$PLUG_DIR/plug.vim" ]; then
	  #ask for installation
    echo "Install vim-plug?"
		read -p "(y/n)" yn
		if [[ $yn = [yY] ]]; then
			echo "installing vim-plug"
			echo
			if [ ! -d "$PLUG_DIR" ]; then
		 		mkdir -p "$PLUG_DIR"
			fi
      curl -fLo "${PLUG_DIR}/plug.vim" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
			echo
		fi
  else
    echo vim-plug is already installed
  fi
}

