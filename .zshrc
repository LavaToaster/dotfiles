# Source zplug
export ZPLUG_HOME=~/.zplug

if [[ ! -d ~/.zplug ]]; then
  echo "Installing zplug"
  curl -sL https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [[ ! -d ~/.SpaceVim ]]; then
  curl -sLf https://spacevim.org/install.sh | bash
fi

source $ZPLUG_HOME/init.zsh

zplug "lib/compfix", from:oh-my-zsh, defer:0
zplug "lib/completion", from:oh-my-zsh, defer:0
zplug "lib/termsupport", from:oh-my-zsh, defer:0

zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/aws", from:oh-my-zsh

zplug "djui/alias-tips"
zplug "oconnor663/zsh-sensible"
zplug "b4b4r07/enhancd", use:init.sh
zplug "plugins/terraform", from:oh-my-zsh

zplug "zsh-users/zsh-completions", defer:0

# Misc
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-autosuggestions", defer:3
zplug "mafredri/zsh-async", defer:0

# Theme
zplug "sindresorhus/pure", use:pure.zsh, as:theme

# Check for uninstalled plugins.
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi


source /usr/local/opt/asdf/asdf.sh

zplug load

if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

### COMPLETIONS ###
type tmuxp &> /dev/null && eval "`_TMUXP_COMPLETE=source tmuxp`"

# ZSH history
setopt append_history
setopt hist_expire_dups_first
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_lex_words
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

zmodload -i zsh/complist

export CLICOLOR=1
export BLOCK_SIZE=human-readable # https://www.gnu.org/software/coreutils/manual/html_node/Block-size.html
export HISTSIZE=11000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
export ZSH_PLUGINS_ALIAS_TIPS_TEXT='    '
export ZSH_CACHE_DIR=$ZSH/cache

# Fix colour being used
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'

### KEY BINDINGS ###
KEYTIMEOUT=1 # Prevents key timeout lag.
bindkey -e

zmodload zsh/terminfo

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

# Bind UP and DOWN arrow keys for subsstring search.
if zplug check zsh-users/zsh-history-substring-search; then
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
fi

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line
fi

# Set Aliases, I Guess.

alias l='ls -lAh'

export EDITOR="nvim"

if which nvim >/dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
fi

# Load local file if it exists
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

brew-sync() {
  brew bundle --file=~/macos/Brewfile
}

