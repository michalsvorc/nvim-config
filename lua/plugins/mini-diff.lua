-- https://github.com/echasnovski/mini.diff
-- Work with diff hunks.
return {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  version = false,
  keys = {
    {
      "<leader>gh",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
      desc = "Hunk diff",
    },
  },
  opts = {
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "",
      },
    },
  },
  config = function(_, opts)
    require("mini.diff").setup(opts)
  end,
}
