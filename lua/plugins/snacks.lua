-- https://github.com/folke/snacks.nvim
-- A collection of small QoL plugins for Neovim.
--
-- The initial loading happens in "plugins/init.lua".
-- This configuration file provides additional options.

return {
  "snacks.nvim",
  opts = {
    bigfile = {
      enabled = true,
      size = 1.5 * 1024 * 1024, -- 1.5MB
    },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = false },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = false }, -- we set this in options.lua
    toggle = { map = LazyVim.safe_keymap_set },
    words = { enabled = true },
    zoom = { enabled = false },
  },
}
