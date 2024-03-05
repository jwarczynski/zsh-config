#!/bin/sh

# Zsh
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Map apt to nala if available
which nala 1>/dev/null && alias apt='nala'

# Colorize `grep` - Use normal `grep` with proper flag
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'

# Colorize `ls` by default
alias ls='ls --color=auto'
alias la='ls -A'

# Easier to read `free` and `df`
alias free='free -m'
alias df='df -h'

# Git
alias gitst='git status'

# Use tmux in 256 colors
alias tmux='tmux -2'

# Fix SSH while using kitty
if [[ $TERM == "xterm-kitty" ]]; then
  alias ssh='kitty +kitten ssh'
fi

# Kubernetes
alias k='kubectl'

alias fixmouse='sudo modprobe -rv psmouse ; sudo modprobe -v psmouse'

# vim rc location
alias vim='vim -u ~/vim_config/.vimrc'

