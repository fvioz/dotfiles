#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath $0)")
FILE=$SCRIPT_DIR/../helpers.sh

if [ -f $FILE ]; then
    . $FILE
fi

header "💪 Stowing dotfiles..."

stow --adopt --restow --verbose=${VERBOSE:-0} --target="$HOME" */
