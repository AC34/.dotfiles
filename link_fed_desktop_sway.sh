#!/usr/bin/bash

#since fedora 32

#user check
if [ $(whoami) = "root" ]; then
  echo "You're running script as root."
  echo "Run as a user"
  exit
fi

#initializing directory path
DOT_HOME="${HOME}/.dotfiles"

#creating dotfiles links list
LINKS_TO=($(find $DOT_HOME/fed_dotfiles/ -type f -name "*"))

#link dotfiles
for TO in "${LINKS_TO[@]}" ; do
  #defining base directory
  FROM=${TO/.dotfiles\/fed_dotfiles\//}
  echo "link from:$FROM to:$TO"
  #making sure edirectory exists
    if [ ! -d $(dirname $FROM) ]; then
      mkdir -p $(dirname $FROM)
    fi
  #now link 
  ln -sfn $TO $FROM 
done

#creating dotfiles links list
LINKS_TO=($(find $DOT_HOME/fed_config/ -type f -name "*"))

#link dotfiles
for TO in "${LINKS_TO[@]}" ; do
  #defining base directory
  FROM=${TO/.dotfiles\/fed_config/.config}
  echo "link from:$FROM to:$TO"
  #making sure edirectory exists
    if [ ! -d $(dirname $FROM) ]; then
      mkdir -p $(dirname $FROM)
    fi
  #now link 
  ln -sfn $TO $FROM 
done

#creating .desktop files links list
LINKS_TO=($(find $DOT_HOME/fed_local/share/applications -type f -name "*"))

for TO in "${LINKS_TO[@]}" ; do
  #defining base directory
  FROM=${TO/.dotfiles\/fed_local/.local}
  echo "link from:$FROM to:$TO"
  #making sure edirectory exists
    if [ ! -d $(dirname $FROM) ]; then
      mkdir -p $(dirname $FROM)
    fi
  #now link 
  ln -sfn $TO $FROM 
done

echo "linking done"



