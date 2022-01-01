#!/usr/bin/env zsh

alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias hbu="brew bundle update --file=$HOME/.config/macos/Brewfile"
alias hbx="brew bundle check --file=$HOME/.config/macos/Brewfile"
alias hbc="brew bundle cleanup --file=$HOME/.config/macos/Brewfile"
