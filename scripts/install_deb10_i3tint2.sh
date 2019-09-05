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

#backports,contrib,non-free registeration
printf "deb http://deb.debian.org/debian/ buster main contrib non-free
deb-src http://deb.debian.org/debian/ buster main contrib non-free

deb http://security.debian.org/debian-security buster/updates main contrib non-free
deb-src http://security.debian.org/debian-security buster/updates main contrib non-free

# buster-updates, previously known as 'volatile'
deb http://deb.debian.org/debian/ buster-updates main contrib non-free
deb-src http://deb.debian.org/debian/ buster-updates main contrib non-free

deb http://deb.debian.org/debian/ buster-backports main contrib non-free

#virtualbox6.0
deb http://download.virtualbox.org/virtualbox/debian bionic contrib
" >> /etc/apt/sources.list

#install apps
echo "installing multiple apps for desktop enviroment" >> $LOG_FILE
echo "this might take a while."


apt install -y xorg xinit lightdm dbus-x11

echo "removing vim-tiny. vim-gtk will be installed instead." >> $LOG_FILE
apt remove vim-tiny

apt install -y i3 vim-gtk ntfs-3g sudo rofi compton compton-conf htop ufw xbacklight pulseaudio network-manager bash-completion feh nm-tray tlp udiskie fonts-vlgothic psmisc universal-ctags libxrandr2 arandr ranger python3 python3-pip cmus git powerline fonts-powerline

echo "installation finished at $(date)" >> $LOG_FILE

#backlight setting
echo "setting xbacklight. This setting may only work for displays with intel drivers." >> $LOG_FILE
echo "when backlight doesn't work after reboot, you can delete /etc/x11/xorg.conf.d/20-intel.conf" >> $LOG_FILE
#make sure directory exists
XORG_DIR=/etc/X11/xorg.conf.d/
if [ ! -d $XORG_DIR ]; then
  mkdir $XORG_DIR
fi
#make sure file exists
XBACKLIGHTCONF="${XORG_DIR}20-intel.conf"
if [ ! -f $XBACKLIGHTCONF ]; then
  touch "${XORG_DIR}20-intel.conf" 
fi
#check if setting exists
if ! grep -q "Identifier \"Intel Graphics\"" "$XBACKLIGHTCONF"; then
echo "xbacklight config not written. newly writing setting" >> $LOG_FILE
printf "Section \"Device\"
   Identifier \"Intel Graphics\"
   Driver \"Intel\"
   Option \"Backlight\" \"intel_backlight\"
EndSection" >> $XBACKLIGHTCONF
fi

#japanese locale setting
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
     printf "[Seat:*]\ngreeter-session=lightdm-greeter\nhide-users=false\nsession-wrapper=/etc/X11/Xsession\n" > $LIGHTDM_CONF
  fi
fi
#[SeatDefaults] setting
#set seat defaults
if ! grep -Eixq ".*default-user.*=.*" $LIGHTDM_CONF; then
  echo "printing new seat deafults" >> $LOG_FILE
  printf "[SeatDefaults]\ndefault-user=${inst_user}" >> $LIGHTDM_CONF
fi

#ufw
echo "Ufw Setting" >> $LOG_FILE
ufw default DENY
ufw enable

#end of the installation
echo "Reached the end of the installation. rebooting." >> $LOG_FILE


