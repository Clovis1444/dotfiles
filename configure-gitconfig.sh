#!/bin/bash
blue() { echo -e "\033[34m$1\033[0m"; }
green() { echo -e "\033[32m$1\033[0m"; }
yellow() { echo -e "\033[33m$1\033[0m"; }

f_in="${HOME}/dotfiles/.gitconfig.in"
f_out="${HOME}/dotfiles/.gitconfig"

rm -f $f_out || exit 1
cp $f_in $f_out || exit 1

read -p "Enter $(blue "user.name"): " name
sed -i "s/name = @/name = ${name}/" $f_out || return 1

read -p "Enter $(blue "user.email"): " email
sed -i "s/email = @/email = ${email}/" $f_out || return 1

echo "$(green "Success")! Your gitconfig was written into $(blue "$f_out")."
echo "Don't forget to run '$(yellow "cd ${HOME}/dotfiles && stow .")' if you didn't run it before."
