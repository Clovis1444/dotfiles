# About

This is my dotfiles for **Arch**-**Niri**-**DankMaterialShell** setup.

# Install

```bash
cd $HOME
git clone https://github.com/Clovis1444/dotfiles.git
cd ./dotfiles
./configure-gitconfig.sh
stow .
```

> [!IMPORTANT]
> For installing dependencies see [system-setup.sh](system-setup.sh).

# Usage

This repo uses [Stow](https://www.gnu.org/software/stow/) for managing dotfiles.

Do all dotfiles changes inside `~/dotfiles/`.

To add new config to the repo do:
```bash
mv ~/.config/nvim ~/dotfiles/.config/nvim
stow ~/dotfiles
```

> [!TIP]
> To make changes into `.gitconfig` edit [~/dotfiles/.gitconfig.in](.gitconfig.in), then run [configure-gitconfig.sh](configure-gitconfig.sh).
