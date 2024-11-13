#!/bin/bash
# This is a script that installs Clovis1444/nvim-conf
# Note: your nvim convig will be overwritten

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
cd "$SCRIPT_DIR" || exit 1

CONF_DIR="$HOME/.config/nvim"

if [ "$SCRIPT_DIR" = "$CONF_DIR" ]; then
    echo 'Running script from ~/.config/nvim dir is not allowed!'
    exit 1
fi

rm -rf $CONF_DIR
cp -r . $CONF_DIR
rm -f $CONF_DIR/install_conf.sh
