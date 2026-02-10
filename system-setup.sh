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

# You probable need to install some MS fonts.
# See https://wiki.archlinux.org/title/Microsoft_fonts

# You may want to enable multilib to install steam and other 32-bit apps.
# See https://wiki.archlinux.org/title/Official_repositories#multilib

# Packages to install
packages=(
    steam
    # Flameshot and its dependencies
    grim
    flameshot
    # Development
    emacs
    ripgrep
    fd
)

pacman -S "${packages[@]}"

# Install doom emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
# Use `M-x -> nerd-icons-install-fonts` after doom installation
