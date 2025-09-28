#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath $0)")
FILE=$SCRIPT_DIR/../helpers.sh

if [ -f $FILE ]; then
    . $FILE
fi

DOTFILES_HOME="$HOME/dotfiles"

if dir_exists $DOTFILES_HOME; then
    green_header "Dotfiles configuration found."
else
    header "🎮 Downloading dotfiles configuration..."
    mkdir -p "$(dirname $DOTFILES_HOME)"
    git clone https://github.com/fvioz/dotfiles "$DOTFILES_HOME" || error "Failed to clone dotfiles repository."
fi
