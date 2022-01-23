#!/usr/bin/env bash

set -eu

is_app_installed() {
  type "$1" &>/dev/null
}

# get data either form stdin or from file. "$@" returns array of every argument
buf=$(cat "$@")

if is_app_installed xclip; then
	echo $buf | xclip -sel clip -i &>/dev/null
fi
