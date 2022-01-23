#!/usr/bin/env bash
set -eu

while (true); do nc -l -p 5556 | xclip -i -sel clip ; done &
