# navigation
alias .="echo $PWD"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias d="dirs -v"

alias c="clear"
alias l='ls -lAh'

# reload
alias rl="exec zsh -l"
alias rll="rm -f $ZCOMPDUMP_PATH; rl"
alias zconfig="$EDITOR $ZDOTDIR/.zshrc"

# apps
# alias tmux="tmux -f $XDG_CONFIG_HOME/tmux.d/tmux.conf"
alias vi="nvim"
alias vim="nvim"
alias v="nvim"
