#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath $0)")
FILE=$SCRIPT_DIR/../helpers.sh

if [ -f $FILE ]; then
    . $FILE
fi

if command_exists brew; then
    green_header "Homebrew found."
else
    header "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" || error "Failed to install Homebrew."
fi
