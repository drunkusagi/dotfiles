#!/bin/bash

set -euo pipefail

CONFIG_TYPE="${1:-}"
WHAT_CONFIG="${2:-}"
PREFIX_CONFIG_DIR="$(dirname "$(realpath "$0")")"
CONFIG_DIR_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
DOT_DIR_HOME="$HOME"

help_message() {
  cat <<EOM
Usage: $0 [config|dot <config name>] [all|--dry-run]

Examples:
  $0 config nvim       # Link a specific config directory
  $0 dot zshrc         # Link a specific dotfile
  $0 all               # Link all configs and dotfiles
  $0 all --dry-run     # Show what would be linked without making changes
EOM
  exit 1
}

dry_run=false
if [[ "${WHAT_CONFIG:-}" == "--dry-run" || "${3:-}" == "--dry-run" ]]; then
  dry_run=true
fi

link_config() {
  local config_dir="$PREFIX_CONFIG_DIR/config/$1"
  local config_dir_dest="$CONFIG_DIR_HOME/$1"

  if [ ! -d "$config_dir" ]; then
    printf "Error: Config '%s' not available\n" "$1"
    exit 1
  fi

  if [ "$dry_run" = true ]; then
    printf "Dry-run: Would link %s to %s\n" "$config_dir" "$config_dir_dest"
    return
  fi

  [ -d "$config_dir_dest" ] || [ -L "$config_dir_dest" ] && rm -rf "$config_dir_dest"

  printf "Linking: %s \033[0;33mto\033[0m %s\n" "$config_dir" "$config_dir_dest"
  ln -sf "$config_dir" "$config_dir_dest"
}

link_dot() {
  local dot_file="$PREFIX_CONFIG_DIR/dot/$1"
  local dot_config_dest="$DOT_DIR_HOME/.$1"

  if [ ! -f "$dot_file" ]; then
    printf "Error: Dot config file '%s' not available\n" "$1"
    exit 1
  fi

  if [ "$dry_run" = true ]; then
    printf "Dry-run: Would link %s to %s\n" "$dot_file" "$dot_config_dest"
    return
  fi

  [ -f "$dot_config_dest" ] || [ -L "$dot_config_dest" ] && rm -rf "$dot_config_dest"

  printf "Linking: %s \033[0;33mto\033[0m %s\n" "$dot_file" "$dot_config_dest"
  ln -sf "$dot_file" "$dot_config_dest"
}

link_all() {
  for c in "$PREFIX_CONFIG_DIR"/config/*; do
    link_config "${c##*/}"
  done

  for c in "$PREFIX_CONFIG_DIR"/dot/*; do
    link_dot "${c##*/}"
  done
}

if [ $# -lt 1 ]; then
  help_message
fi

case "$CONFIG_TYPE" in
  "config") link_config "$WHAT_CONFIG" ;;
  "dot") link_dot "$WHAT_CONFIG" ;;
  "all") link_all ;;
  *)
    printf "Unknown config type '%s'\n\n" "$CONFIG_TYPE"
    help_message
    ;;
esac
