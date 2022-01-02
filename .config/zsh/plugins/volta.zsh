export VOLTA_HOME=${VOLTA_HOME:-"${XDG_DATA_HOME}/volta"}
export path=(${VOLTA_HOME}/bin(N-/) ${path})

if [[ ! $(command -v volta) ]]; then
    # `curl` is called in volta installer too, so it is required
    if [[ $(command -v curl) ]]; then
        curl https://get.volta.sh | bash -s -- --skip-setup
        volta install node@lts
        volta install yarn
    else
        echo '`volta` has not been installed yet. But install process needs `curl`' 1>&2
        return 1
    fi
fi

if [[ ! -s "$XDG_DATA_HOME/zsh/site-functions/_volta" ]]; then
    volta completions zsh -f -o "$XDG_DATA_HOME/zsh/site-functions/_volta"
fi
