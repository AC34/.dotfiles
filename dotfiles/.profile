#!/usr/bin/env bash

export GTK_IM_MODULE=ibus
export XMODIFIERS=@in=ibus
export QT_IM_MODULE=ibus

function linkPath(){
  if [ -f "$1" ]; then
    PATH="$1"
  fi
}


linkPath "$HOE/.bashr"
linkPath "$HOME/bin:$PATH"
linkPath "$HOME/.local/bin"
linkPath "/snap/bin"
 


