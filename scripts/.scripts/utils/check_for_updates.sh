#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath $0)")
FILE=$SCRIPT_DIR/../helpers.sh

if [ -f $FILE ]; then
    . $FILE
fi

check_for_updates() {
    local CURRENT_TIME=$(date +%s)

    if [[ -f $HOME/.last_update_check ]]; then
        LAST_CHECK=$(cat $HOME/.last_update_check)
    else
        echo $CURRENT_TIME > $HOME/.last_update_check
        LAST_CHECK=0
    fi

    local TIME_DIFF=$((CURRENT_TIME - LAST_CHECK))
    local DAYS=$((15 * 24 * 60 * 60))

    if (( TIME_DIFF > DAYS )); then
        update_tools
    fi
}

check_for_updates
