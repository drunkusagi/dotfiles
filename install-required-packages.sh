#!/usr/bin/bash

set -e

IFS=$'\n' read -r -d '' -a PACKAGES <pkgs.txt || true

setup_cachyos_repo() {
  local curr_dir
  curr_dir=$(pwd)

  cd /tmp
  curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
  tar xvf cachyos-repo.tar.xz && cd cachyos-repo
  sudo ./cachyos-repo.sh || true
  cd "$curr_dir"
}

disable_debug_flag() {
  echo "Disabling debug flag"
  sudo sed -i 's/purge debug/purge !debug/g' /etc/makepkg.conf || true
}

if ! command -v yay >/dev/null 2>&1; then
  echo "Installing yay aur helper"
  sudo pacman -Sy
  sudo pacman -S --needed --noconfirm git base-devel
  git clone --depth 1 https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  yes | makepkg -si
  cd ..
  rm -rf yay-bin
fi

disable_debug_flag
setup_cachyos_repo

yes | yay -S --noconfirm "${PACKAGES[@]}"
