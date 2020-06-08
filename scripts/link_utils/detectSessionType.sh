#!/usr/bin/env bash

#echoes string
#"unknown" unknown mode
#"nogui" no gui at all (server)
#"x11" x11 session
#"wayland" wayland session
function detectSessionType(){
  #server
  if [ -z "$XDG_SESSION_TYPE" ]; then echo "nogui"; return; fi

  #session type value based detection
  if [ "$XDG_SESSION_TYPE" = "x11" ]; then echo "x11"; return; fi
  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then echo "wayland"; return; fi

  #0 when reaching this line
  echo "unknown";
  return;
}
