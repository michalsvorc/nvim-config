# Neovim configuration

## Dependencies

- Neovim >=0.11
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- [npm](https://github.com/npm/cli)
- [fd](https://github.com/sharkdp/fd)
- [NerdFont](https://github.com/ryanoasis/nerd-fonts)

## LazyVim

This configuration is built on [LazyVim](https://github.com/LazyVim/LazyVim/), but it does not use [the starter template](https://github.com/LazyVim/starter) or LazyVim as a plugin.
Instead, it directly loads LazyVim configuration files from lua/lazyvim, providing greater flexibility for customization.

## Local configuration

### lua/config/_local.lua

Enables local overrides for config options.

### lua/plugins/_local/

Facilitates adding local plugin specifications. Any plugin specifications placed in this directory are not tracked by version control.
