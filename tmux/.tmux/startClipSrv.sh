#!/usr/bin/env bash

while (true); do nc -l -p 5556 | xclip -i -sel clip ; done &
