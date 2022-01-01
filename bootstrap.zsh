#!/usr/bin/env zsh

fancy_echo() {
  # shellcheck disable=SC2039
  local fmt="$1"
  shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

fancy_echo 'Installing yadm'

brew install yadm

fancy_echo 'Cloning repo'
yadm clone git@github.com:LavaToaster/dotfiles.git

fancy_echo 'Setting up macOS defaults'
source $HOME/.config/macos/defaults

fancy_echo "Installing formulas and casks from the Brewfile ..."
brew bundle --file=$HOME/.config/macos/Brewfile
