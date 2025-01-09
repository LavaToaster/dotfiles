#!/usr/bin/env zsh

if [[ ! -d "$XDG_DATA_HOME/zsh/site-functions" ]]; then
  mkdir -p "$XDG_DATA_HOME/zsh/site-functions"
fi;

# install functions
fpath=("$ZDOTDIR/functions" $fpath)
fpath=("$XDG_DATA_HOME/zsh/site-functions" $fpath)
autoload $ZDOTDIR/functions/*
# autoload $XDG_DATA_HOME/zsh/site-functions/*

if [[ -d "/opt/homebrew" ]]; then
  path=("/opt/homebrew/bin" $path)
fi

# Install zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Initialize completion system first
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

if [ -n "${TMUX}" ]; then
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
fi

# Completion Plugins
zinit light zsh-users/zsh-completions
#zinit light marlonrichert/zsh-autocomplete
zinit light Aloxaf/fzf-tab 

# Theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Theme
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure

# Utility
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zdharma-continuum/history-search-multi-word
zinit light zsh-users/zsh-history-substring-search

source "$ZDOTDIR/aliases/aliases.zsh"
if [[ "$OSTYPE" =~ 'darwin' ]]; then
  source "$ZDOTDIR/aliases/darwin.zsh"
fi

LOCAL_ALIASES="$ZDOTDIR/aliases/local.zsh"
if [[ -f $LOCAL_ALIASES ]]; then
  source $LOCAL_ALIASES
fi

if type brew &>/dev/null; then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

source $ZDOTDIR/plugins/*

path=("$HOME/.dotnet/tools" $path)

# autoload -Uz compinit
# # Load and initialize the completion system ignoring insecure directories with a
# # cache time of 20 hours, so it should almost always regenerate the first time a
# # shell is opened each day.
# _comp_files=($ZCOMPDUMP_PATH(Nm-20))
# if (( $#_comp_files )); then
#     compinit -i -C -d "$ZCOMPDUMP_PATH"
# else
#     compinit -i -d "$ZCOMPDUMP_PATH"
# fi
# unset _comp_files
#
# zinit cdreplay -q 

autoload bashcompinit && bashcompinit
complete -C aws_completer aws
complete -o nospace -C /opt/homebrew/bin/terramate terramate

# Use case-insensitive globbing.
unsetopt caseglob

# glob dotfiles as well
setopt globdots

# use extended globbing
setopt extendedglob

# Automatically change directory if a directory is entered
setopt autocd

# history
HISTFILE="$XDG_CACHE_HOME/zsh/history"
if [[ ! -f $HISTFILE ]]; then
  mkdir -p "${HISTFILE%/*}" && touch "$HISTFILE"
fi

HISTSIZE=10000000
SAVEHIST=10000000

setopt SHARE_HISTORY      # Share history between all sessions
setopt HIST_IGNORE_DUPS   # Do not record an event that was just recorded
setopt HIST_IGNORE_SPACE  # Do not record an event starting with a space
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks from each command line being added to the history list.
setopt HIST_VERIFY        # Do not execute immediately upon history expansion
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt EXTENDED_HISTORY   # Save timestamps in history

# Keybindings
source $ZDOTDIR/keybindings.zsh

export PATH="$PATH:$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/Users/adam/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
