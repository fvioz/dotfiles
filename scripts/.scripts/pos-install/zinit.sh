#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath $0)")
FILE=$SCRIPT_DIR/../helpers.sh

if [ -f $FILE ]; then
    . $FILE
fi

# Zinit (Plugin manager directory)
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"

if dir_exists $ZINIT_HOME; then
    green_header "Zinit found."
else
    header "📎 Installing Zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
