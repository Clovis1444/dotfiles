# About

This is my dotfiles. It uses [chezmoi](https://github.com/twpayne/chezmoi) to deploy dotfiles to other machines.

For more info see: https://www.chezmoi.io/

# Deploy

With [chezmoi](https://github.com/twpayne/chezmoi) you can install chezmoi and your dotfiles from your GitHub dotfiles repo on a new, empty machine with a single command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

# Usage

See this [article](https://www.chezmoi.io/quick-start/).
