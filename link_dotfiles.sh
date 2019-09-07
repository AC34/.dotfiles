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

#create links list
LINKS_TO=($(find $DOT_HOME/dotfiles/ -name ".*"))

#link
for TO in "${LINKS_TO[@]}" ; do
  FROM=${TO/.dotfiles\/dotfiles\//}
  echo "linking FROM=${FROM} TO=$TO"
	ln -sf $TO $FROM
done



