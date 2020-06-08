#!/usr/bin/env bash

#creating installing user variable
INST_USER=$(whoami)

#create installation dir
mkdir /home/$INST_USER/.local/share/fonts
#move to the directory
pushd /home/$INST_USER/.local/share/fonts

#check the existance of wget command
if [ $(command -v wget) = "" ]; then
  echo "wget is mising. install it."
  exit
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
