#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    # to add dotfiles directoy i added a symlink of dotfiles to the project folder
    # and use the -L flag to also find symlnks
    export FZF_DEFAULT_OPTS='--height 100% --layout=reverse --border --color=fg:#f8f8f2,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
    selected=$(find -L ~/Projects ~/Projects/lernfair -mindepth 1 -maxdepth 1 -type d | fzf --bind 'K:up,J:down')
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
