-- https://github.com/stevearc/dressing.nvim
-- Neovim plugin to improve the default vim.ui interfaces
local winopts = require("plugins.fzf.winopts")

return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    -- vim.ui.input
    input = {
      enabled = false,
    },
    -- vim.ui.select
    select = {
      enabled = true,
      backend = { "fzf_lua", "fzf", "builtin" },
      fzf_lua = {
        winopts = winopts.small_window,
      },
    },
  },
}
