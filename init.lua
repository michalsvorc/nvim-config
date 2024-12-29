-- package manager
require(".lazy")

-- LazyVim config
local LazyVim = require(".lazyvim")
LazyVim.setup({
  colorscheme = "catppuccin",
  news = {
    lazyvim = false,
    neovim = false,
  },
})

require(".commands")
