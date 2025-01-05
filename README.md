# Neovim configuration

Based on [LazyVim/starter](https://github.com/LazyVim/starter) with custom loading of [LazyVim](https://github.com/LazyVim/LazyVim) configs and plugins.

Maintains custom extra plugins with `:ExtrasEnable` command.

## Dependencies

- [Neovim](https://neovim.io/) >=0.11
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- [npm](https://github.com/npm/cli)
- [fd](https://github.com/sharkdp/fd)
- [NerdFont](https://github.com/ryanoasis/nerd-fonts)

## Local configuration

### lua/config/_local.lua

Enables local overrides for config options.

### lua/plugins/_local/

Facilitates adding local plugin specifications. Any plugin specifications placed in this directory are not tracked by version control.

## Custom snippets

Read [blink.cmp](https://cmp.saghen.dev/configuration/snippets.html#custom-snippets) guide.

- [vscode snippet spec](https://code.visualstudio.com/docs/editor/userdefinedsnippets)
- [friendly-snippets examples](https://github.com/rafamadriz/friendly-snippets/tree/main/snippets)

## References

### LazyVim

- [News](https://www.lazyvim.org/news)

### lazy.nvim

- [News](https://lazy.folke.io/news)
- [Plugin Specification](https://lazy.folke.io/spec)
