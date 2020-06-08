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
source $SCRIPTS/linkDirs.sh

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
echo
#common .config files
linkDirs $DOT_HOME/config .dotfiles/config .config "1"
echo

#----------------------------------------------------
#-----------------------------no gui setting (server)
#----------------------------------------------------
if [ "$MODE" = "nogui" ]; then
  #end the script
  echo linking files for no gui done
fi

#----------------------------------------------------
#----------------------------------------x11 settings
#----------------------------------------------------
if [ "$MODE" = "x11" ]; then
	#common .desktop files
  linkFiles $DOT_HOME/local/share/applications ".dotfiles/local" ".local" "1"
	#x11 based files
  linkFiles "$DOT_HOME/local_alters/x11/share/applications" ".dotfiles/local_alters/x11" ".local" "1"

  #end the script
  echo linking files for x11 done
fi

#----------------------------------------------------
#------------------------------------wayland settings
#----------------------------------------------------
if [ "$MODE" = "wayland" ]; then
  #common .desktop files
  linkFiles $DOT_HOME/local/share/applications ".dotfiles/local" ".local" "1"
	#x11 based files
  linkFiles "$DOT_HOME/local_alters/wayland/share/applications" ".dotfiles/local_alters/wayland" ".local" "1"
  #end the script
  echo linking files for wayland done
fi

#intall vim-plug 
#this function contains dialog
prepareVimPlug

#install mplus nerdfont
echo install MPlus Nerdfont?
read -p "(y/n)" yn
if [[ $yn = [yY] ]]; then
	echo installing vimplug
  prepareVimPlug
else
	echo skipping nerdfont installation
fi

echo All dotfiles settings are done
