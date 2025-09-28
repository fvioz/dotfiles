#!/bin/bash

VERBOSE=0

load_script() {
    local local_script_path="${HOME}/.scripts/$1"

    if [ -f "$local_script_path" ] ; then
        . "$local_script_path"
    else
        load_remote_script $1
    fi
}

load_remote_script() {
    local url="https://raw.githubusercontent.com/fvioz/dotfiles/HEAD/scripts/.scripts/$1"
    local temp_file
    temp_file=$(mktemp)
    if curl -fsSL "$url" -o "$temp_file"; then
        . "$temp_file"
        rm "$temp_file"
    else
        echo "\033[0;31m 🚫 Error:\033[0m Script '$1' not found."
        echo "\033[1;33m ⚠️ Warning:\033[0m Failed to download script from '$url'."
        rm "$temp_file"
        exit -1
    fi
}


install() {
    # Load helpers
    load_script helpers.sh

    info "\n🚀 Starting installation...\n"

    # Pre-install
    load_script pre-install/xcode.sh
    load_script pre-install/homebrew.sh
    load_script pre-install/clone.sh

    cd $HOME/dotfiles || error "Failed to change directory to $HOME/dotfiles"

    # Install
    load_script install/brewfile.sh
    load_script install/stow.sh

    # Post-install
    load_script pos-install/zinit.sh
    # load_script pos-install/shell.sh

    info "\n🎉 Installation completed! Please restart your terminal."
}

install
