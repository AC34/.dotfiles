#!/usr/bin/env bash

echo "Starting debian i3 tint2 japanese installation."

#confirm changes
echo 
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
		echo
		echo "user needs to be logged in as root. you are \"$(whoami)\" now."	
	echo "login as root by \"su\" and try again."
	exit
fi

#select user for installation
echo
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

#sources.list backports,contrib,non-free registeration
echo "" >> $LOG_FILE
echo "updating sources.list" >> $LOG_FILE
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
echo "" >>$LOG_FILE
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

apt install -y bash-completion feh nm-tray tlp udiskie bc
apt -y autoremove

apt install -y fonts-vlgothic psmisc universal-ctags libxrandr2 arandr ranger 
apt -y autoremove

apt -y install python3 python3-pip cmus git powerline fonts-powerline
apt -y autoremove

echo "installation finished at $(date)" >> $LOG_FILE

#register user as sudoer
echo "" >> $LOG_FILE
echo "registering $inst_user as sudoer" >> $LOG_FILE
#calling "usermod" might not work
USERMOD=$(whereis usermod | cut -d' ' -f2 )
USERMOD="${USERMOD} -aG sudo $inst_user"

#japanese locale setting
echo "" >>$LOG_FILE
echo "Locale Setting" >> $LOG_FILE
echo "Current Locale is:$LANG"  >> $LOG_FILE
echo "If you want to change locale setting, press y"
echo "press n to avoid making changes."
read -n1 -p "press y or n" yn
if [[ $yn = [yY] ]]; then
  dpkg-reconfigure locales
  echo "locale changed to $LANG" >> $LOG_FILE
	echo "changes you made take effect after reboot."
fi


#japanese input setting
echo "" >>$LOG_FILE
echo "Japanese input Seting" >> $LOG_FILE
echo "Install and Enable Japanese Input(ibus-mozc)?"
echo "press y to make changes"
echo "press n to avoid making changes."
read -n1 -p "press y or n:" yn
if [[ $yn = [yY] ]]; then
  echo "Enabling Japanese Input" >> $LOG_FILE
  apt install -y ibus-mozc
  echo "instaled ibus-mozc" >> $LOG_FILE 
fi

#keyboard setting
echo "" >> $LOG_FILE
echo "Keyboard Setting" >> $LOG_FILE
echo "Configure Keyboard Setting?"
echo "press y to make changes"
echo "press n to avoid making changes."
read -n1 -p "press y or n:" yn
if [[ $yn = [yY] ]]; then
  dpkg-reconfigure keyboard-configuration
	setupcon
fi

#make swappiness to 1
SYSCTL_CONF=/etc/sysctl.conf
echo "" >> $LOG_FILE
echo "Swappiness setting" >> $LOG_FILE
if ! grep -q "vm.swappiness=1.*" "/etc/sysctl.conf"; then
	CURRENT_SWAPPINESS=$(cat $SYSCTL_CONF | grep "vm.swappiness" | sed --quiet "s/vm.swappiness.*=//g")
  echo "Current Swappiness is $CURRENT_SWAPPINESS"
  echo "Do you want to set swappines to 1?"
  echo "press y to make changes"
  echo "press n to avoid making changes."
  read -n1 -p "press y or n:" yn
  if [[ $yn = [yY] ]]; then
  #delete the old swappines setting lineif exists  
  sed -i "/.*vm.swappiness.*/d" $SYSCTL_CONF
  #append new swappiness setting
	echo "setting swappiness to 1"
  printf "\nvm.swappiness=1\n" >> $SYSCTL_CONF
  fi
else
  echo "swappiness is already set to 1. making no changes." >> $LOG_FILE
fi


#tmpfs
echo "" >> $LOG_FILE
echo "Tmpfs setting" >> $LOG_FILE
echo "Do auto tmpfs setting?"
echo "press y to make changes"
echo "press n to avoid making changes."
read -n1 -p "press y or n:"
if [[ $yn = [yY] ]]; then
  FSTAB="/etc/fstab"
  echo #for the sake of giving a  new line
	#user's cache directory
	if ! grep -q "tmpfs /home/$inst_user/.cache.*" "/etc/fstab"; then
    echo "putting user's cache directory on tmpfs." >> $LOG_FILE
    printf "\ntmpfs /home/$inst_user/.cache tmpfs nodev,nosuid,noatime,size=1024M	0	0\n" >> $FSTAB
  else
    echo "user's cache folder is already on tmpfs. making no change." >> $LOG_FILE
  fi
  #tmp on tmpfs
	if ! grep -q "tmpfs /tmp.*" "/etc/fstab"; then
    echo "putting /tmp on tmpfs." >> $LOG_FILE
    printf "tmpfs /tmp tmpfs nodev,nosuid,noatime,size=1024M	0	0\n" >> $FSTAB
  else
    echo "/tmp is already on tmpfs. making no change." >> $LOG_FILE
  fi
fi


#lightdm gtk
echo "" >> $LOG_FILE
echo "lightdm gtk greeter setting" >> $LOG_FILE
LIGHTDM_CONF=/usr/share/lightdm/lightdm.conf.d/01_debian.conf
if ! [ -f $LIGHTDM_CONF ]; then
		echo "conf did not exist=$LIGHTDM_CONF" >> $LOG_FILE
		echo "creating new one." >> $LOG_FILE
    touch $LIGHTDM_CONF
fi
#[Seat:*] setting
#list users by setting false to greeter-hide-users
if grep -Eixq ".*hide-users.*=.*true.*" $LIGHTDM_CONF; then
	LCONF=$(cat $LIGHTDM_CONF | sed -r "s/.*hide-users.*=.*true/hide-users=false/g")
	echo "$LIGHTDM_CONF modified, now showing users at login." >> $LOG_FILE
	printf "$LCONF" > $LIGHTDM_CONF
else
  if grep -Eixq ".*greeter-hide-users.*=.*false.*" $LIGHTDM_CONF; then
		echo "greeter-hide-users is already false." >> $LOG_FILE
  else
#no preset user property set.
#writing brand new setting
     printf "[Seat:*]\ngreeter-session=lightdm-greeter\ngreeter-hide-users=false\nsession-wrapper=/etc/X11/Xsession\n" > $LIGHTDM_CONF
  fi
fi
#[SeatDefaults] setting
#set seat defaults
if ! grep -Eixq ".*default-user.*=.*" $LIGHTDM_CONF; then
  echo "printing new seat deafults" >> $LOG_FILE
  printf "\n\n[SeatDefaults]\ndefault-user=${inst_user}" >> $LIGHTDM_CONF
fi

#ufw
echo "" >> $LOG_FILE
echo "Ufw Setting" >> $LOG_FILE
ufw default DENY
ufw enable

#end of the installation
echo "" >> $LOG_FILE
echo "Reached the end of the installation. rebooting." >> $LOG_FILE
