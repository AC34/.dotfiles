#!/usr/bin/env bash


#now start linking

#create dotfiles links list
LINKS_TO=($(find $DOT_HOME/deb_dotfiles/ -type f -name "*"))

#link
for TO in "${LINKS_TO[@]}" ; do
  FROM=${TO/.dotfiles\/deb_dotfiles\//}
	#making sure directory exists
	if [ ! -d $(dirname $FROM) ]; then
    mkdir -p $(dirname $FROM)
  fi
	ln -sfn $TO $FROM
done


#create .config links list
LINKS_TO=($(find $DOT_HOME/deb_config/ -type f -name "*"))

#link
for TO in "${LINKS_TO[@]}" ; do
  FROM=${TO/.dotfiles\/deb_config/.config}
	#making sure directory exists
	if [ ! -d $(dirname $FROM) ]; then
    mkdir -p $(dirname $FROM)
  fi
	ln -sfn $TO $FROM
done

#create .desktop links list
LINKS_TO=($(find $DOT_HOME/local/ -type f -name "*.desktop"))

#link
for TO in "${LINKS_TO[@]}" ; do
  FROM=${TO/.dotfiles\/deb_local/.local}
	#making sure directory exists
	if [ ! -d $(dirname $FROM) ]; then
    mkdir -p $(dirname $FROM)
  fi
	ln -sfn $TO $FROM
done


#clear font cache data
fc-cache -vf /usr/share/fonts

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


