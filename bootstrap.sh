#!/bin/bash

fancy_echo() {
  # shellcheck disable=SC2039
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
  curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

fancy_echo 'Installing yadm'

brew install yadm

fancy_echo 'Cloning repo'
yadm clone git@github.com:Lavoaster/dotfiles.git
yadm submodule update --init --recursive

touch ~/.zshrc.local

echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc.local

fancy_echo "Installing formulas and casks from the Brewfile ..."
brew bundle --file=$HOME/macos/Brewfile
