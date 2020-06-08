#!/usr/bin/env bash

#manual setting
MAX_BRIGHTNESS=1.0
CURRENT_BRIGHTNESS=$(xrandr --current --verbose | grep -m 1 "Brightness:" | cut -d " " -f2)
#addition
CURRENT_BRIGHTNESS=$(echo "$CURRENT_BRIGHTNESS + 0.1" | bc -l )
#acquiring display name
CURRENT_DISPLAY=$(xrandr -q | grep -m 1 " connected" | cut -d " " -f1)


#force max brightness value
if (( $(echo "$CURRENT_BRIGHTNESS > $MAX_BRIGHTNESS" | bc -l) )); then 
		CURRENT_BRIGHTNESS=$MAX_BRIGHTNESS
fi

#force quit if no display was found
if [ $CURRENT_DISPLAY = "" ]; then
  echo "no display found"
  exit
fi

#DEBUG
#echo "current display=${CURRENT_DISPLAY} brightness=${CURRENT_BRIGHTNESS}"

#update brightness
$(xrandr --output $CURRENT_DISPLAY --brightness $CURRENT_BRIGHTNESS)
