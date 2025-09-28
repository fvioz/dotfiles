#!/bin/bash
#
SCRIPT_DIR=$(dirname "$(realpath $0)")
FILE=$SCRIPT_DIR/../helpers.sh

if [ -f $FILE ]; then
    . $FILE
fi

if command_exists xcode-select -p; then
    green_header "Xcode found."
else
    header "⚙️ Installing Xcode Command Line Tools..."
    xcode-select --install || error "Failed to install Xcode Command Line Tools."
    sudo xcodebuild -license accept
fi
