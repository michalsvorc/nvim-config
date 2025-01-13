-- https://github.com/echasnovski/mini.diff
-- Work with diff hunks.

return {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  version = false,
  keys = {
    {
      "<leader>hd",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
      desc = "Diff hunks",
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
    mappings = {
      -- Stage hunks inside a visual/operator region
      apply = "<leader>hs",

      -- Reset hunks inside a visual/operator region
      reset = "<leader>hx",

      -- Hunk range textobject to be used inside operator
      -- Works also in Visual mode if mapping differs from apply and reset
      textobject = "H",
    },
  },
  config = function(_, opts)
    require("mini.diff").setup(opts)
  end,
}
