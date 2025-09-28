#!/bin/bash

BLUE='\033[0;34m'
BLUE_BOLD='\033[1;34m'
GREEN='\033[0;32m'
GREEN_BOLD='\033[1;32m'
RED_BOLD='\033[1;31m'
YELLOW_BOLD='\033[1;33m'
RESET_COLOR='\033[0m'
BOLD='\033[1m'

ask_for_confirmation() {
    while true; do
        echo -n "${BOLD}${1}${RESET_COLOR} [y/n]: "
        read response
        case "$response" in
        [yY]) return 0 ;;
        [nN]) return 1 ;;
        *)
            echo ""
            warning "Please answer y or n.\n"
            ;;
        esac
    done
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

dir_exists() {
    [ -d "$1" ]
}

header() {
    echo "${BLUE_BOLD}==> ${RESET_COLOR}${BOLD}${1}${RESET_COLOR}"
}

green_header () {
    echo "${GREEN_BOLD}==> ✅ ${RESET_COLOR}${BOLD}${1}${RESET_COLOR}"
}

info() {
    echo "${BLUE}${1}${RESET_COLOR}"
}

success() {
    echo "${GREEN}${1}${RESET_COLOR}"
}

error() {
    echo "\n${RED_BOLD}🚫 Error: ${RESET_COLOR}${1}"
    exit 1
}

warning() {
    echo "${YELLOW_BOLD}⚠️ Warning: ${RESET_COLOR}${1}"
}
