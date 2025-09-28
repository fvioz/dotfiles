#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath $0)")
FILE=$SCRIPT_DIR/../helpers.sh

if [ -f $FILE ]; then
    . $FILE
fi

if [ "$SHELL" == *"zsh"* ]; then
    green_header "Zsh is already the default shell."
else
    header "🐚 Changing default shell to Zsh..."
    chsh -s $(which zsh)
fi
