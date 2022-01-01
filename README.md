# Adam's dotfiles

## Fresh OS Install Method:

Supposedly simple setup for macOS:

```
curl -L https://raw.githubusercontent.com/LavaToaster/dotfiles/main/bootstrap.zsh | zsh
```

## Tips:

### Homebrew maintenance:

I've found throughout the years since I finally setup a dotfiles repo that maintaining
 a list of active programs and things you install via `brew` comes and go's.

I'll be making this more and more strict in the future, but for now interaction
 with homebrew if you plan on keeping a tool or app should be updating `~/.config/mac/Brewfile`
 then running `hbu`.

As time passes and the apps you have installed change you can use `hbc` to run 
 a [cleanup check](https://docs.brew.sh/Manpage#bundle-subcommand) and it will list
 apps you've installed via brew but haven't declared in `Brewfile`.
  