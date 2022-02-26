# ~/.bashrc: executed by bash(1) for non-login shells.

# ==========================
# ====  General Settings ===
# ==========================

# If not running interactively, don't do anything. Only for ssh and remote shiet
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# vi keymap on command line
set -o vi

# for nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# better cd
. ~/z.sh



# ==========================
# ========  Prompt =========
# ==========================

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/-(\1)/p'
}

if [ "$color_prompt" = yes ]; then
    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    prompt_symbol=😈
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
	prompt_color='\[\033[;94m\]'
	info_color='\[\033[1;31m\]'
	prompt_symbol=👽
    fi
	if [ -n "$SSH_CLIENT" ]; then text=" ssh"
	fi
	PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}('$info_color'\u${prompt_symbol}\h'$prompt_color')$(parse_git_branch)-[\[\033[0;1m\]\w'$prompt_color']${text}\n'$prompt_color'└─'$info_color'\$\[\033[0m\] '
    # BackTrack red prompt
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# auto exec tmux and neofetch
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	exec tmux
fi



# ==========================
# ========  SSH Mod =========
# ==========================

# different color in ssh shell
myssh() {
	if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
		# in tmux
		printf '\033Ptmux;\033\033]50;%s\007\033\\' "colors=Ssh"
		# remote clipboard
		ssh $1 -R 5556:localhost:5556
		printf '\033Ptmux;\033\033]50;%s\007\033\\' "colors=Dracula"
	else
		# not in tmux
		konsoleprofile colors=Ssh
		ssh $1
		konsoleprofile colors=Dracula
	fi
}
alias ssh='myssh'



# ==========================
# ========  Neofetch =========
# ==========================

KONSOLE_INSTANCES=0
for pid in $(pidof -x konsole); do
	KONSOLE_INSTANCES=$((KONSOLE_INSTANCES+1))
done

TMUX_INSTANCES=$(tmux list-panes | wc -l)
# for pid in $(pidof -x tmux); do
# 	TMUX_INSTANCES=$((TMUX_INSTANCES+1))
# done

if [ $KONSOLE_INSTANCES -le 1 ] && [ $TMUX_INSTANCES -le 1 ]; then
	neofetch
fi



# ==========================
# =====  Colored shiet =====
# ==========================

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

