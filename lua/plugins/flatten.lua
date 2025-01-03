-- https://github.com/willothy/flatten.nvim
-- Pipe from wezterm, kitty, and neovim terminals into your current neovim instance.

return {
  "willothy/flatten.nvim",
  -- Ensure that it runs first to minimize delay when opening file from terminal.
  -- Setting terminal events did not work.
  lazy = false,
  priority = 1001,
  opts = {},
}
