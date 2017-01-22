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

fancy_echo 'Setting up some prezto symlinks'
# Link some pretzo stuff
ln -s $HOME/.zlogin $HOME/.zprezto/runcoms/zlogin
ln -s $HOME/.zlogout $HOME/.zprezto/runcoms/zlogout
ln -s $HOME/.zprofile $HOME/.zprezto/runcoms/zprofile

touch ~/.zshrc.local

echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc.local

fancy_echo 'Running mac installer'

bash $HOME/macos/mac install
