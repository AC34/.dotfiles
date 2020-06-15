#!/usr/bin/env bash

#11 settings
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
  #compositor
  if [ "$(command -v picom)" != "" ]; then
  	#picom first
    picom -b &
  elif [ "$(command -v compton)" != "" ]; then
    #then compton
    compton -b &
  fi

  #background with feh
  if [ "$(command -v feh)" != "" ]; then
    feh --bg-fill ~/.wallpaper.png &
  fi

  #polybar


	#ibus input
  if [ "$(command -v ibus-daemon)" != "" ]; then
	  ibus-daemon -dx &
	fi
fi #x11
