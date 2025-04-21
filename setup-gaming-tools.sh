#!/usr/bin/bash

set -e

PACMAN_PKGS=(
  wine-staging lutris
  # graphics drivers
  vulkan-headers vulkan-icd-loader vulkan-intel vulkan-tools libva-intel-driver intel-gmmlib intel-media-driver vkd3d mesa
  # 32-bit drivers and libraries
  lib32-gnutls lib32-mesa lib32-vkd3d lib32-vulkan-icd-loader lib32-vulkan-intel lib32-vulkan-mesa-layers lib32-vkd3d
  # other tools
  mangohud lib32-mangohud gamemode lib32-gamemode
)

echo "Installing packages..."

sudo pacman -Sy

sudo pacman -S --noconfirm "${PACMAN_PKGS[@]}"
