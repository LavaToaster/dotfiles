export ZPLG_HOME="${:-$HOME/.}zplugin"

if [[ ! -d $ZPLG_HOME ]]; then
  echo "Installing zplugin"
  curl -sL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh | bash
fi

source "${ZPLG_HOME}/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light zdharma/zui
zplugin light zdharma/zplugin-crasis

zplugin ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

zplugin snippet OMZ::lib/compfix.zsh
zplugin snippet OMZ::lib/completion.zsh
zplugin light zsh-users/zsh-completions

zplugin light mafredri/zsh-async

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

zplugin light zdharma/fast-syntax-highlighting
zplugin light zdharma/history-search-multi-word
zplugin light zsh-users/zsh-history-substring-search

zplugin light zsh-users/zsh-autosuggestions

setopt auto_cd

# ZSH history
setopt append_history
setopt hist_expire_dups_first
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_lex_words
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

export CLICOLOR=1
export BLOCK_SIZE=human-readable # https://www.gnu.org/software/coreutils/manual/html_node/Block-size.html
export HISTSIZE=11000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
export ZSH_CACHE_DIR=$ZSH/cache

# Key Bindings
KEYTIMEOUT=1 # Prevents key timeout lag.
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
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      history-substring-search-up
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    history-substring-search-down
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# TMUX / TPM Setup

if [[ ! -d ${HOME}/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
fi

# NVM Setup

export NVM_DIR="${:-$HOME/.}nvm"

if [[ ! -d $NVM_DIR ]]; then
  echo "Installing NVM"
  mkdir $NVM_DIR
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

  echo "Please modify ${HOME}/.zshrc to remove the line of code that the NVM installer added"
fi

nvm() {
  echo "🚨 NVM not loaded! Loading now..."
  unset -f nvm
  load_nvm
  nvm "$@"
}

# Credit: https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs/
declare -a NODE_GLOBALS=(`find ${NVM_DIR}/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

NODE_GLOBALS+=("node")
NODE_GLOBALS+=("nvm")

load_nvm () {
    [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"
}

for cmd in "${NODE_GLOBALS[@]}"; do
    eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
done

# Aliases

alias .='echo $PWD'
alias l='ls -lAh'
alias -g ...='../..'
alias -g ....='../../..'

# Config

## If nvim exists, use it as default vim, and override vi/vim to use it.
if which nvim >/dev/null 2>&1; then
  export EDITOR="nvim"

  alias vi='nvim'
  alias vim='nvim'
fi

# Load local file if it exists (this isn't commited to the dotfiles repo)
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

autoload -Uz compinit
handle_completion_insecurities
compinit -i -C -d "${ZSH_COMPDUMP}"

zplugin cdreplay -q
