#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath $0)")
FILE=$SCRIPT_DIR/../helpers.sh

if [ -f $FILE ]; then
    . $FILE
fi

if command brew bundle check>/dev/null 2>&1; then
    green_header "Brewfile packages installed."
else
    header "🎒 Installing Brewfile packages..."

    brew bundle install --upgrade
fi
