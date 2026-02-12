# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# [PATH]
path+=('/home/clovis/.config/emacs/bin')

# [ENV]
export EDITOR='nvim'
export TERMINAL='alacritty'

# [ALIAS]
# Better cat
alias cat="bat --paging=never"
# Better ls
alias ls="eza"
