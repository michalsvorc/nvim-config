-- https://github.com/echasnovski/mini.statusline
-- Minimal and fast statusline module with opinionated default look.
return {
  "echasnovski/mini.statusline",
  version = false,
  dependencies = { "echasnovski/mini.icons" },
  event = "VeryLazy",
  config = function()
    require("mini.statusline").setup()
  end,
}
