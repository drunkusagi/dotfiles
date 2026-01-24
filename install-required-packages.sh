#!/usr/bin/bash

set -e

PACKAGES=(
  7zip alacritty alsa-firmware arch-install-scripts base base-devel bat brightnessctl btop bun calf clang cliphist dhclient discord easyeffects efibootmgr eza fastfetch fd filelight fuzzel fvm fzf git
  gnome-keyring grub gst-libav gvfs-smb htop intel-gmmlib intel-media-driver intel-ucode iwd jq kitty intel-media-driver linux-firmware linux-zen lsp-plugins-lv2 lutris lvm2 ly matugen mda.lv2
  mesa-utils mpv neovim networkmanager niri noctalia-shell noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ntfs-3g nushell nvm nvtop open-iscsi openresolv openssh otf-font-awesome pipewire
  pipewire-alsa pipewire-pulse playerctl polkit-gnome power-profiles-daemon pwvucontrol qbittorrent qpwgraph qt5-multimedia qt5-wayland reflector ripgrep rofi rustup scx-scheds scx-tools sndio sudo swayidle
  thunar tigervnc tlp tlpui tmux unrar unzip uwsm vulkan-headers vulkan-intel vulkan-mesa-layers vulkan-tools wev wget wireplumber wl-clipboard xdg-desktop-portal-gnome xfsprogs xwayland-satellite yay yelp zam-plugins-lv2 zip
  zoxide zsh google-chrome jid-bin osu-lazer-bin spotify
)

setup_cachyos_repo() {
  local curr_dir
  curr_dir=$(pwd)

  cd /tmp
  curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
  tar xvf cachyos-repo.tar.xz && cd cachyos-repo
  sudo ./cachyos-repo.sh
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
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  yes | makepkg -si
  cd ..
  rm -rf yay-bin
fi

disable_debug_flag
setup_cachyos_repo

yes | yay -S --noconfirm "${PACKAGES[@]}"
