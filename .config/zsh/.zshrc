#!/usr/bin/env zsh

# install functions
fpath=("$ZDOTDIR/functions" $fpath)
autoload $ZDOTDIR/functions/*

# zinit setup
if [[ ! -d $ZINIT_HOME ]]; then
  echo "Installing zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

declare -A ZINIT

ZINIT[ZCOMPDUMP_PATH]="$ZCOMPDUMP_PATH"

source "${ZINIT_HOME}/zinit.zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# prompt
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit load sindresorhus/pure

zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

zinit load zshzoo/zstyle-completions

zinit load zdharma-continuum/fast-syntax-highlighting
zinit load zdharma-continuum/history-search-multi-word
zinit load zsh-users/zsh-history-substring-search
zinit load zsh-users/zsh-autosuggestions

source "$ZDOTDIR/aliases/aliases.zsh"
if [[ "$OSTYPE" =~ 'darwin' ]]; then
  source "$ZDOTDIR/aliases/darwin.zsh"
fi

autoload -Uz compinit
# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
_comp_files=($ZCOMPDUMP_PATH(Nm-20))
if (( $#_comp_files )); then
    compinit -i -C -d "$ZCOMPDUMP_PATH"
else
    compinit -i -d "$ZCOMPDUMP_PATH"
fi
unset _comp_files

zinit cdreplay -q 

# Use case-insensitve globbing.
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
# setopt appendhistory notify
# unsetopt beep nomatch

# Append History instead of replacing it after each session
setopt appendhistory

# Treat the '!' character specially during expansion.
setopt bang_hist

# Write to the history file immediately, not when the shell exits.
setopt inc_append_history

# Share history between all sessions.
setopt share_history

# Expire a duplicate event first when trimming history.
setopt hist_expire_dups_first

# Do not record an event that was just recorded again.
setopt hist_ignore_dups

# Delete an old recorded event if a new event is a duplicate.
setopt hist_ignore_all_dups

# Do not display a previously found event.
setopt hist_find_no_dups

# Do not record an event starting with a space.
setopt hist_ignore_space

# Do not write a duplicate event to the history file.
setopt hist_save_no_dups

# Do not execute immediately upon history expansion.
setopt hist_verify

# Show timestamp in history
setopt extended_history

# completion stuff
if type brew &>/dev/null; then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi


# keyboard setup

# Prevents key timeout lag.
KEYTIMEOUT=1
# enables emacs keybindings mode
bindkey -e

zmodload zsh/terminfo

typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[Alt-Left]=${terminfo[kLFT3]}
key[Alt-Right]=${terminfo[kRIT3]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# From: https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/key-bindings.zsh
# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey "${key[Insert]}"    overwrite-mode
[[ -n "${key[Delete]}"    ]] && bindkey "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey "${key[Up]}"        history-substring-search-up
[[ -n "${key[Down]}"      ]] && bindkey "${key[Down]}"      history-substring-search-down
[[ -n "${key[Left]}"      ]] && bindkey "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey "${key[Right]}"     forward-char
[[ -n "${key[Alt-Left]}"  ]] && bindkey "${key[Alt-Left]}"  backward-word
[[ -n "${key[Alt-Right]}" ]] && bindkey "${key[Alt-Right]}" forward-word
bindkey "^[[1;9D" backward-word
bindkey "^[[1;9C" forward-word
bindkey '^[^?' backward-kill-word
