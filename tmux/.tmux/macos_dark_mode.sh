#!/bin/bash

# Check the macOS Dark Mode setting
if [[ "$(defaults read -g AppleInterfaceStyle)" == "Dark" ]]; then
    # macOS is in Dark Mode, so set the configuration for Dark Mode
    tmux source-file ~/.tmux.dark.conf
else
    # macOS is in Light Mode, so set the configuration for Light Mode
    tmux source-file ~/.tmux.light.conf
fi
