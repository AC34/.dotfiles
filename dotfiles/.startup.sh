#!/usr/bin/env bash

#startup script
#  general
#    launch ibus daemon 
#  x11
#    launch rxvt daemon 
#		arandr(possibly load settings)
#		call compositor(picom->compton)
#  wayland

#	  wdisplays(possibly load settings)
#--------------------------------common settings
#launch udiskie
if [ $(command -v udiskie) != "" ]; then
	 udiskie &
fi


#--------------------------------x11 settings
if [ $XDG_SESSION_TYPE = "x11" ]; then

	 #load monitor setting of xrandr if exists
  if [ -f $HOME/.screenlayout/autostart.sh ]; then
    $HOME/.screenlayout/autostart.sh  
		fi
	  
	 #launch compositor
  if [ $(command -v picom) != "" ]; then
    picom &
		else if [ $(command -v compton) != "" ]; then
				#try compton if no picom
				compton &
		fi

		#launching bar
  if [ $(command -v polybar) != "" ]; then
    polybar &
		else if [ $(command -v tint2) != "" ]; then
				#try tint2 if no picom
				tint2 &
		fi

		#launch wifi manager
  if [ $(command -v dbus-launch) != "" ]; then
    dbus-launch --exit-with-session nm-tray &
		fi

  #set wallpaper
  if [ $(command -v nitrogen) != "" ]; then
    nitrogen --restore &
  fi


  #open up the memo
		if [ -f ~/memo/todo ]; then
		  rxvt -e ~/memo/todo
		fi
fi


#--------------------------------wayland settings
if [ $XDG_SESSION_TYPE = "wayland" ]; then
  
fi


