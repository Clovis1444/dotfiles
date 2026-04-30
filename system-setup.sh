#!/bin/bash

cd ~
# Update pacman
sudo pacman -Syu

# First thing first - install fastfetch
sudo pacman -S fastfetch

# Install initial packages
sudo pacman -S git firefox nvim alacritty thunar wl-clipboard stow tldr ttf-ubuntu-font-family

# Install zapret
# Option 1:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/Snowy-Fluffy/zapret.installer/refs/heads/main/installer.sh)"
# Option2:
# https://github.com/Sergeydigl3/zapret-discord-youtube-linux

# Install paru AUR helper
cd ~
sudo pacman -S rustup
rustup default stable
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ~
rm -rf paru

# Install DankGreeter
paru -S greetd-dms-greeter-git
dms greeter enable
dms greeter sync

# Install JetBrains Mono Nerd font
sudo pacman -S ttf-jetbrains-mono-nerd

# Install shell
sudo pacman -S zsh zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Telegram, Discord
sudo pacman -S telegram-desktop discord

# Install lazygit, delta, bat, eza
sudo pacman -S lazygit git-delta bat eza

# You probable need to install some MS fonts.
# See https://wiki.archlinux.org/title/Microsoft_fonts

# You may want to enable multilib to install steam and other 32-bit apps.
# See https://wiki.archlinux.org/title/Official_repositories#multilib

# Packages to install
packages=(
    dms-shell      # Dank Material Shell
    dms-shell-niri # Dank Material Shell
    jre-openjdk
    jre8-openjdk
    flatpak
    steam
    libreoffice-fresh
    krita
    calligra
    inkscape
    less
    xfce4-settings
    grim      # Flameshot and its dependencies
    flameshot # Flameshot and its dependencies
    emacs   # Emacs
    ripgrep # Emacs
    fd      # Emacs``
    poppler           # Dired deps
    ffmpegthumbnailer # Dired deps
    mediainfo         # Dired deps
    imagemagick       # Dired deps
    tar               # Dired deps
    unzip             # Dired deps
    # Dev packages
    uv # Python project manager
    #
    snap-pac # Btrfs snapshots after system update
    syncthing
    wgcf # generate wg private key
    zerotier-one # Virtual LAN
)
pacman -S "${packages[@]}"

aur_packages=(
    ttf-symbola
    brother-hll2300d # Printer driver
    # Btrfs snapshots integration for Limine
    # For setup instructions see: https://gitlab.com/Zesko/limine-snapper-sync#arch-linux
    limine-mkinitcpio-hook
    limine-snapper-sync
    #
    tg-ws-proxy-bin # Telegram proxy
    amneziavpn-bin
)
paru -S "${aur_packages[@]}"

# Install doom emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# [DEVELOPMENT]
# Install rust-analyzer
rustup component add rust-analyzer rust-src
