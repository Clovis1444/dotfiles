# About

This is my dotfiles. It uses [chezmoi](https://github.com/twpayne/chezmoi) to deploy dotfiles to other machines.

> [!TIP]
> For more info see: https://www.chezmoi.io/

# Dependencies

- [Alacritty](https://github.com/alacritty/alacritty)
- [Nerd font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip)
- Git
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [delta](https://github.com/dandavison/delta)


## Nvim

- python3
- make
- yarn
- cargo
- cmake


# Deploy

With [chezmoi](https://github.com/twpayne/chezmoi) you can install chezmoi and your dotfiles from your GitHub dotfiles repo on a new, empty machine with a single command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

# Usage

See this [article](https://www.chezmoi.io/quick-start/).
