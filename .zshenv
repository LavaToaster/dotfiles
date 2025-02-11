#!/usr/bin/env zsh

# set config variables
ZDOTDIR="$HOME/.config/zsh"
source $HOME/.config/env

# Paths

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/.local/bin
  $path
)
. "$HOME/.cargo/env"
