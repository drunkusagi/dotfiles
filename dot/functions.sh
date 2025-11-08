#!/usr/bin/bash

function change_wallpaper() {
  local wp_path
  wp_path="$(realpath "$1")"

  hyprctl hyprpaper preload "$wp_path" >/dev/null 2>&1
  hyprctl hyprpaper wallpaper eDP-1,"$wp_path" >/dev/null 2>&1
}

nvim() {
  if ! pidof socat >/dev/null 2>&1 && [ -n "$WSL_INTEROP" ]; then
    [ -e /tmp/discord-ipc-0 ] && rm -f /tmp/discord-ipc-0
    socat UNIX-LISTEN:/tmp/discord-ipc-0,fork \
      EXEC:"npiperelay.exe //./pipe/discord-ipc-0" 2>/dev/null &
  fi

  if [ $# -eq 0 ]; then
    command nvim
  else
    command nvim "$@"
  fi
}
