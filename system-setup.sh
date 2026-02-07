#!/bin/bash

cd ~
# Update pacman
sudo pacman -Syu

# First thing first - install fastfetch
sudo pacman -S fastfetch

# Install initial packages
sudo pacman -S git firefox nvim alacritty thunar wl-clipboard stow tldr ttf-ubuntu-font-family

# Install zapret
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Snowy-Fluffy/zapret.installer/refs/heads/main/installer.sh)"

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

# Install DMS
curl -fsSL https://install.danklinux.com | sh
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
