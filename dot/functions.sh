#!/usr/bin/bash

function change_wallpaper() {
  local wp_path
  wp_path="$(realpath "$1")"

  hyprctl hyprpaper preload "$wp_path" >/dev/null 2>&1
  hyprctl hyprpaper wallpaper eDP-1,"$wp_path" >/dev/null 2>&1
}
