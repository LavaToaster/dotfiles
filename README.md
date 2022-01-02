# Adam's dotfiles

## Fresh OS Install Method:

Supposedly simple setup for macOS:

```
curl -L https://raw.githubusercontent.com/LavaToaster/dotfiles/main/bootstrap.zsh | zsh
```

## General Philosophy/Notes:

Going into this iteration of my dotfiles I wanted to ensure that it followed [XDG Base Directory](https://wiki.archlinux.org/title/XDG_Base_Directory)
 specs for apps. So you'll find all config for everything, unless hardcoded and required, under `$HOME/.config`. 

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

### Shell Autocomplete:

Installed a new tool and completion isn't working? Try running `rll` which will remove the zsh completion dump and reload
 the shell. If it still doesn't work ensure that completions can be found on `$fpath`

This is done as a performance measure to ensure that zsh isn't constantly compiling completion code and slowing down
 terminal setup.

## Credits:

These dotfiles are inspired via the following repos:

- https://gitlab.com/yramagicman/stow-dotfiles/
- https://github.com/optimizacija/neovim-config/ (for neovim lua config)

Tools used/configured:

- [zinit](https://github.com/zdharma-continuum/zinit) - zsh plugin manager
- [yadm](https://yadm.io/) - dotfiles manager
- [zsh](https://www.zsh.org/)
- [volta](https://volta.sh/) - used for node/npm/yarn version management
- [neovim](https://neovim.io/)
- Maybe more that I haven't listed because I've forgotten to update the readme.