#!/usr/bin/env bash

#Warning
#Use linkFiles,linkDirs for linking
#those will take restorable backups with .dot_bak attrbiutes for files/directories

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
#------------------------run unlink script first
#----------------------------------------------------

bash ./unlink_all.sh

#----------------------------------------------------
#----------------------------------------preparations
#----------------------------------------------------
#sourcing scripts
SCRIPTS="$(cd $(dirname $0); pwd)/scripts/link_utils"
source $SCRIPTS/detectSessionType.sh
source $SCRIPTS/prepareVimPlug.sh
source $SCRIPTS/linkFiles.sh
source $SCRIPTS/linkDirs.sh

#initializing variables
DOT_HOME=$(cd $(dirname $0); pwd)
MODE=$(detectSessionType)


#----------------------------------------------------
#-------------------------------------common settings
#----------------------------------------------------
#install fonts to .dotfiles(late will be linked)
echo "intall fonts?"
#check for fonts existance
read -p "(y/n)" yn
if [[ $yn = [yY] ]]; then
  #download and instal fonts in .dotfiles
  pushd "$DOT_HOME/local/share/"
    git clone https://github.com/AC34/fonts.git
  popd
  #link those files of .dotifles dir to ./local/share/fonts
  #this way, deleting can be done because those link are able to be found
  echo "fonts dir:$DOT_HOME/local/share/fonts"
fi
#linking common files(dotfiles)
linkFiles "$DOT_HOME/dotfiles" ".dotfiles/dotfiles/" "" "0"
echo
#common .config files
linkDirs "$DOT_HOME/config" ".dotfiles/config" ".config" "0"
echo
#.local/share directories
linkDirs "$DOT_HOME/local/share" ".dotfiles/local" ".local" "0"


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
  #linkFiles "$DOT_HOME/local/share/applications" ".dotfiles/local" ".local" "0"
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
  #linkFiles "$DOT_HOME/local/share/applications" ".dotfiles/local" ".local" "0"
	echo
	#x11 based files
  linkFiles "$DOT_HOME/local_alters/wayland/share/applications" ".dotfiles/local_alters/wayland" ".local" "0"
	echo
  #end the script
  echo linking files for wayland done
fi

#intall vim-plug
#this function contains dialog
prepareVimPlug $DOT_HOME

#update fonts cache
fc-cache -f

echo
echo All dotfiles settings are done
