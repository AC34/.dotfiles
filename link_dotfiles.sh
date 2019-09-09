#!/usr/bin/env bash


#user check
if [ whoami = "root" ]; then
  echo "logged in as root, please login as a user"
	exit
fi

#initialize directory path
DOT_HOME="${HOME}/.dotfiles"

#make sure .dotfiles directory exists
if [ ! -d $DOT_HOME ]; then
  mkdir $DOT_HOME
fi

#prepare git if not installed
#should always be installed though
if [ $(command -v git) = "" ]; then
		if [ $(command -v sudo) = ""]; then
		 echo "sudo and git not installed.can't proceed."
		 echo "abort"
		 exit
		else 
				echo "sudo found but git not installed. installing git."
				sudo apt install git
		fi
fi

#clone git repo if not found
cd $DOT_HOME
if [ ! -d "${DOT_HOME}/.git" ]; then 
  echo "git repo not found. cloning." 
  git clone git@github.com:AC34/dotfiles.git $DOT_HOME
fi


#now start linking

#create dotfiles links list
LINKS_TO=($(find $DOT_HOME/dotfiles/ -type f -name "*"))

#link
for TO in "${LINKS_TO[@]}" ; do
  FROM=${TO/.dotfiles\/dotfiles\//}
	#making sure directory exists
	if [ ! -d $(dirname $FROM) ]; then
    mkdir -p $(dirname $FROM)
  fi
	ln -sfn $TO $FROM
done


#create .config links list
LINKS_TO=($(find $DOT_HOME/config/ -type f -name "*"))

#link
for TO in "${LINKS_TO[@]}" ; do
  FROM=${TO/.dotfiles\/config/.config}
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
  FROM=${TO/.dotfiles\/local/.local}
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
 sudo apt install curl
 #then download vim-plug
 curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
fi


