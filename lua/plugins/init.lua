-- Initialize LazyVim configuration
require("lazyvim.config").init()

-- https://github.com/folke/snacks.nvim
-- A collection of small QoL plugins for Neovim.
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {},
}
