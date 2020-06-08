#!/usr/bin/env bash

#----------------------------------------------------
#-------------------------------------privilege check
#----------------------------------------------------
#user check
if [ "$(whoami)" = "root" ]; then
  echo "logged ina as root"
  echo "login as a user"
  exit
fi

#----------------------------------------------------
#----------------------------------------preparations
#----------------------------------------------------
#sourcing scripts
SCRIPTS="$HOME/.dotfiles/scripts/link_utils"
source $SCRIPTS/detectSessionType.sh
source $SCRIPTS/prepareVimPlug.sh
source $SCRIPTS/linkFiles.sh

#initializing variables
DOT_HOME="$HOME/.dotfiles"
MODE=$(detectSessionType)

echo "dot home is $DOT_HOME"
echo "scripts are at  $SCRIPTS"
echo "gui mode is $MODE"

#----------------------------------------------------
#-------------------------------------common settings
#----------------------------------------------------

#linking common files(dotfiles)
linkFiles "$DOT_HOME/dotfiles" ".dotfiles/dotfiles/" "" "1"

#----------------------------------------------------
#-----------------------------no gui setting (server)
#----------------------------------------------------
if [ "$MODE" = "nogui" ]; then
	echo entering mode $MODE
  #link nvim setting
  ln -sfn $HOME/.dotfiles/config/nvim $HOME/.config/nvim
  #end the script
  echo linking files for no gui done
fi

#----------------------------------------------------
#----------------------------------------x11 settings
#----------------------------------------------------
if [ "$MODE" = "x11" ]; then
	echo entering mode $MODE

  #common .desktop files
  linkFiles "$DOT_HOME/" ".dotfiles/config/" ".config" "1"

  #end the script
  echo linking files for x11 done
fi

#----------------------------------------------------
#------------------------------------wayland settings
#----------------------------------------------------
if [ "$MODE" = "wayland" ]; then
	echo entering mode $MODE
  #configs

  #.desktop files

  #end the script
  echo linking files for wayland done
fi

echo reached the end of the file
