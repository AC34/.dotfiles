#!/usr/bin/env bash

function installNerdfont(){
  #creating installing user variable
  INST_USER=$(whoami)

  #check for the existence
  if [ $(fc-list | grep nerd) != "" ]; then
    echo "nerdfonts seems to be already installed"
  	 return;
  fi

		#ask for installation
		echo "Do you wan to install MPlus nerdfont?"
		read -p "(y/n)" yn
		if [[ $yn = [yY] ]]; then
			 #proceed
		else
			 echo "skiping nerdfont installation"
				return;
		fi
  
  #create installation dir
  mkdir /home/$INST_USER/.local/share/fonts
  #move to the directory
  pushd /home/$INST_USER/.local/share/fonts
  
  #check the existance of wget command
  if [ $(command -v wget) = "" ]; then
    echo "wget is mising. install it."
  	 echo "skipping the process"
  	return;
  fi
  
  #install font via wget
  wget --no-check-certificate --content-disposition https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/MPlus.zip -P /home/$INST_USER/.local/share/fonts/
  #unzip file first
  unzip -o MPlus.zip
  #delete unneeded zip file
  rm MPlus.zip
  
  #back to the directory
  popd
  #update font cache
  fc-cache -f -v
}
