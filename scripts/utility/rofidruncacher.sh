#!/usr/bin/env bash


#this file is loaded right before rofi call, by i3 settings.

#create menu for drun cache-----------------------------

#drun cache will be num name(.desktop) with \n
#e.g. 0 vim.desktop\n
#by manually setting this cache, menu can be controlled.

MENU="4 v.desktop\n"

MENU+="3 f.desktop\n"

MENU+="2 fp.desktop\n"

MENU+="1 c.desktop\n"

MENU+="0 ci.desktop\n"

#write to the cache file
echo -e $MENU > ~/.cache/rofi3.druncache

#functions---------------------------------------------

#tells whether the os is a debian release
#to check run is_debian\n if [ $ret_val == "1"
is_debian () {
 if [ -f "/etc/os-release" ]; then
		#/etc/os-release does not exist for all oses
		. /etc/os-release
		#retrieve os name only
		OS=$NAME
		if [[ $OS == *"Debian"* ]]; then
				ret_val=1
		else
				ret_val=2
		fi
 fi
}
