# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# * Share history immediately across all open terminals
# * Do not store duplicates, and erase them if they occur
# * Always append history; never overwrite it
# * Store multiline commands as a single history entry
shopt -s cmdhist histappend
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
export HISTCONTROL=ignoreboth:erasedups

# Set basic program defaults
export EDITOR=emacsclient
export BROWSER=chromium

# Nice colors for ls output
eval "$(dircolors -b)"
alias ls='ls --color=auto'

# Nice colors for grep output
alias grep='grep --color=auto'

# Nicely formatted less output
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '
LESS_TERMCAP_me=$(printf '\e[0m')
LESS_TERMCAP_se=$(printf '\e[0m')
LESS_TERMCAP_ue=$(printf '\e[0m')
LESS_TERMCAP_mb=$(printf '\e[1;32m')
LESS_TERMCAP_md=$(printf '\e[1;34m')
LESS_TERMCAP_us=$(printf '\e[1;32m')
LESS_TERMCAP_so=$(printf '\e[1;44;1m')
export LESS_TERMCAP_se LESS_TERMCAP_me LESS_TERMCAP_ue LESS_TERMCAP_mb \
       LESS_TERMCAP_md LESS_TERMCAP_us LESS_TERMCAP_so

# Colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# Set prompt
PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

# Add local bin directory to the path
export PATH=$PATH:$HOME/bin

# Load other files
if [ -d ~/.bashrc.d ]
then
    for f in ~/.bashrc.d/*
    do
        # shellcheck disable=SC1090
        source "$f"
    done
fi
