#!/usr/bin/env bash

echo "Starting dotfiles installation."

#confirm changes
echo This script makes various and some significant changes to your OS.
echo The Author of this script is totally not responsible/reliable/accountable for any harm this script does to your OS.
echo You need to be completely sure and totally be responsible of what you are doing with this script.
echo Press \"y\" to proceed. Press 
echo Press \"n\" to abort.
read -n1 -p "press y or n" yn
if [[ $yn = [yY] ]]; then
  echo "y pressed. proceeding"
else
  echo "n pressed. proceeding"
	echo "aborting"
	echo "bye"
	exit
fi

#global variables
USER=""
DISTRO=""
#this nedds tobe modified
LOG_FILE=""

#check weather logged in as root
#abort if user isn't root
if [ `whoami` = "root" ]; then
 echo "logged in as root. continuing"
else
		echo "user needs to be logged in as root. you are \"$(whoami)\" now."	
	echo "login as root by \"su\" and try again."
	exit
fi

#select user for installation
title="User Selection"
prompt="Select user for this isntallation:"
PS3=$prompt
candidates=`ls /home`
select inst_user in $candidates
do
 if [ "$inst_user" = "" ]; then
		 echo "invalid selection. choose again."
 else
   echo "selected $inst_user "
	 break
 fi
done

#make logfile path
LOG_FILE="/home/$inst_user/install_log.txt"

#create log file if needed
if [ ! -f $LOG_FILE ]; then
  echo "creating log file at $LOG_FILE"
  touch $LOG_FILE
fi

#initializing log file
echo "installtion started:$(date)" > $LOG_FILE
if [[ "$(uname -a)" == *"Debian"* ]]; then
		DISTRO=Debian
else
		DISTRO="not supported"
fi

#abort on unsupported os
if [ "$DISTRO" = "not supported" ];then
		echo "distro not supported"
		echo "aborting."
		exit
else
		echo "Distro found as ${DISTRO}. continuing."
fi

#install sudo
#register user as sudoer
echo "registering $inst_user as sudoer" >> $LOG_FILE
#calling "usermod" might not work
USERMOD=$(whereis usermod | cut -d' ' -f2 )
USERMOD="${USERMOD} -aG sudo $inst_user"

echo "preparing sudo available enviroment. "
echo "installing sudo and adding $inst_user to sudo" | tee -a LOG_FILE
echo "login as root:"
su -c "apt install -y sudo && $USERMOD"

#sources.list backports,contrib,non-free registeration
printf "deb http://deb.debian.org/debian/ buster main contrib non-free
deb-src http://deb.debian.org/debian/ buster main contrib non-free

deb http://security.debian.org/debian-security buster/updates main contrib non-free
deb-src http://security.debian.org/debian-security buster/updates main contrib non-free

# buster-updates, previously known as 'volatile'
deb http://deb.debian.org/debian/ buster-updates main contrib non-free
deb-src http://deb.debian.org/debian/ buster-updates main contrib non-free

deb http://deb.debian.org/debian/ buster-backports main contrib non-free

" >> /etc/apt/sources.list

#install apps
echo "installing multiple apps for desktop enviroment" >> $LOG_FILE
echo "this might take a while."


apt install -y xorg xinit lightdm dbus-x11
apt -y autoremove

echo "removing vim-tiny. vim-gtk will be installed instead." >> $LOG_FILE
apt -y remove vim-tiny
apt -y autoremove

apt install -y i3 vim-gtk ntfs-3g sudo rofi compton compton-conf
apt -y autoremove

apt install -y htop ufw xbacklight pulseaudio network-manager
apt -y autoremove

apt install -y bash-completion feh nm-tray tlp udiskie 
apt -y autoremove

apt install -y fonts-vlgothic psmisc universal-ctags libxrandr2 arandr ranger 
apt -y autoremove

apt -y install python3 python3-pip cmus git powerline fonts-powerline
apt -y autoremove

echo "installation finished at $(date)" >> $LOG_FILE

