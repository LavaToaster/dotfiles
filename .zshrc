# Source zplug
export ZPLUG_HOME=~/.zplug

if [[ ! -d ~/.zplug ]]; then
  echo "Installing zplug"
  curl -sL zplug.sh/installer | zsh
fi

source $ZPLUG_HOME/init.zsh

zplug "djui/alias-tips"
zplug "oconnor663/zsh-sensible"
zplug "b4b4r07/enhancd", use:init.sh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/aws", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3 # Should be loaded last.
zplug "zsh-users/zsh-syntax-highlighting", defer:3 # Should be loaded 2nd last.

# Theme.
setopt prompt_subst # Make sure propt is able to be generated properly.
zplug "caiogondim/bullet-train-oh-my-zsh-theme", use:bullet-train.zsh-theme

# Check for uninstalled plugins.
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

BULLETTRAIN_DIR_EXTENDED=2
BULLETTRAIN_GIT_COLORIZE_DIRTY=true
BULLETTRAIN_PROMPT_ORDER=(
  time
  status
  custom
  context
  dir
  git
  cmd_exec_time
)

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

### AUTOSUGGESTIONS ###
# if zplug check zsh-users/zsh-autosuggestions; then
#   ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down) # Add history-substring-search-* widgets to list of widgets that clear the autosuggestion
#   ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}") # Remove *-line-or-history widgets from list of widgets that clear the autosuggestion to avoid conflict with history-substring-search-* widgets
# fi

# Fix colour being used
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'

zplug load

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

alias l='ls -lAh'

if which nvim >/dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
fi

#source ~/.zshrc.local
