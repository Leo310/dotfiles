#!/bin/bash

# Check the macOS Dark Mode setting using AppleInterfaceStyle
if [[ "$(defaults read -g AppleInterfaceStyle)" == "Dark" ]] || [[ "$(darkman get)" == "dark" ]]; then
    # macOS is in Dark Mode or "darkman get" indicates dark appearance, set the configuration for Dark Mode
    tmux source-file ~/.tmux.dark.conf
else
    # macOS is in Light Mode or "darkman get" indicates light appearance, set the configuration for Light Mode
    tmux source-file ~/.tmux.light.conf
fi
