#!/bin/sh

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000
# Do not log commands starting with whitespace and imediate duplicates
export HISTCONTROL=ignorespace:ignoredups
setopt HIST_IGNORE_DUPS

# openmpi
#export C_INCLUDE_PATH=/usr/lib/x86_64-linux-gnu/openmpi/include
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/openmpi/lib

export CPATH=/usr/lib/x86_64-linux-gnu/openmpi/include
export C_INCLUDE_PATH=/usr/lib/x86_64-linux-gnu/openmpi/include


# Path
#export PATH="$HOME/.local/bin":$PATH
#export PATH=$HOME/.cargo/bin:$PATH
#export PATH=$HOME/.fnm:$PATH
export PATH=$HOME/App/IntelliJ/idea-IU-223.8617.56/bin:$PATH

#export MANPAGER='nvim +Man!'
#export MANWIDTH=999

# Environment variables set everywhere
export VISUAL="vim"
export EDITOR="vim"
#export TERMINAL="kitty"
export BROWSER="google-chrome"

# For QT Themes
export QT_QPA_PLATFORMTHEME=qt5ct

# Fix QT auto scaling on high DPI
export QT_AUTO_SCREEN_SCALE_FACTOR=0
