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
#----------------------------------------preparations
#----------------------------------------------------
#sourcing scripts
SCRIPTS="$(cd $(dirname $0); pwd)/scripts/link_utils"
source $SCRIPTS/unlinkFiles.sh
source $SCRIPTS/unlinkDirs.sh

#initializing variables
DOT_HOME=$(cd $(dirname $0); pwd)

#----------------------------------------------------
#-------------------------------------common settings
#----------------------------------------------------
#linking common files(dotfiles)
unlinkFiles "${DOT_HOME}/dotfiles" ".dotfiles/dotfiles/" "" "0"
echo
#common .config files
unlinkDirs "${DOT_HOME}/config" ".dotfiles/config" ".config" "0"
echo
#./local/share
unlinkDirs "${DOT_HOME}/local/share" ".dotfiles/local/share" "./local/share" "0"
#x11
unlinkFiles "${DOT_HOME}/local/share/applications" ".dotfiles/local" ".local" "0"
unlinkFiles "${DOT_HOME}/local_alters/x11/share/applications" ".dotfiles/local_alters/x11" ".local" "0"
#wayland
unlinkFiles "${DOT_HOME}/local/share/applications" ".dotfiles/local" ".local" "0"
echo
unlinkFiles "${DOT_HOME}/local_alters/wayland/share/applications" ".dotfiles/local_alters/wayland" ".local" "0"
echo
#fongs
unlinkFiles "${DOT_HOME}/local/share/fonts" ".dotfiles/local/share" ".local/share" "0"
fc-cache -f


