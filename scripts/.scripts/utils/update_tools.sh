#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath $0)")
FILE=$SCRIPT_DIR/../helpers.sh

if [ -f $FILE ]; then
    . $FILE
fi

update_tools(){
    if ask_for_confirmation "🔄 Do you want to update the tools?" ;then
        brew update && brew upgrade && brew cleanup || error "Failed to update Homebrew."

        echo ""
        header "Updating Zinit..."
        zini self-update && zini update --all || error "Failed to update Zinit."
    fi

    if ask_for_confirmation "🔄 Do you want to update macOS apps?" ;then
        echo ""
        header "Updating macOS software..."
        sudo softwareupdate -i -a || error "Failed to update macOS software."
    fi

    echo $(date +%s) > $HOME/.last_update_check
}
