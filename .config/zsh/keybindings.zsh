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
bindkey "^R" history-search-multi-word
