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
source $SCRIPTS/installNerdfont.sh


#initializing variables
DOT_HOME="$HOME/.dotfiles"
MODE=$(detectSessionType)

#----------------------------------------------------
#-------------------------------------common settings
#----------------------------------------------------

#linking common files(dotfiles)
linkFiles "$DOT_HOME/dotfiles" ".dotfiles/dotfiles/" "" "0"
echo
#common .config files
linkDirs $DOT_HOME/config .dotfiles/config .config "0"
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
  linkFiles $DOT_HOME/local/share/applications ".dotfiles/local" ".local" "0"
	echo
	#x11 based files
  linkFiles "$DOT_HOME/local_alters/x11/share/applications" ".dotfiles/local_alters/x11" ".local" "0"
	echo

  #end the script
  echo linking files for x11 done
fi

#----------------------------------------------------
#------------------------------------wayland settings
#----------------------------------------------------
if [ "$MODE" = "wayland" ]; then
  #common .desktop files
  linkFiles $DOT_HOME/local/share/applications ".dotfiles/local" ".local" "0"
	echo
	#x11 based files
  linkFiles "$DOT_HOME/local_alters/wayland/share/applications" ".dotfiles/local_alters/wayland" ".local" "0"
	echo
  #end the script
  echo linking files for wayland done
fi

#intall vim-plug 
#this function contains dialog
prepareVimPlug

#install mplus nerdfont
#this function contains dialog
installNerdfont

echo
echo All dotfiles settings are done
