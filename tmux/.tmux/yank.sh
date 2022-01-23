#!/usr/bin/env bash

set -eu

# is_app_installed() {
#   type "$1" &>/dev/null
# }

# get data either form stdin or from file. "$@" returns array of every argument
buf=$(cat "$@")

# some nc need -c flag to close instantly after connection 
echo $buf | xclip -sel clip -i
