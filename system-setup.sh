#!/bin/bash

cd ~
# Update pacman
sudo pacman -Syu

# Install git
sudo pacman -S git

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

# Install shell
sudo pacman -S zsh zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# You probable need to install some MS fonts.
# See https://wiki.archlinux.org/title/Microsoft_fonts

# You may want to enable multilib to install steam and other 32-bit apps.
# See https://wiki.archlinux.org/title/Official_repositories#multilib

# Packages to install
packages=(
    fastfetch              # initial packages
    git                    # initial packages
    firefox                # initial packages
    nvim                   # initial packages
    alacritty              # initial packages
    thunar                 # initial packages
    wl-clipboard           # initial packages
    stow                   # initial packages
    tldr                   # initial packages
    ttf-ubuntu-font-family # initial packages
    ttf-jetbrains-mono-nerd # Nerd font
    dms-shell      # Dank Material Shell
    dms-shell-niri # Dank Material Shell
    lazygit   # Shell utils
    git-delta # Shell utils
    bat       # Shell utils
    eza       # Shell utils
    telegram-desktop # Messaging Apps
    discord          # Messaging Apps
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
    greetd-dms-greeter-git # Greeter
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

# Enable DankGreeter
dms greeter enable
dms greeter sync

# Install doom emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# [DEVELOPMENT]
# Install rust-analyzer
rustup component add rust-analyzer rust-src
