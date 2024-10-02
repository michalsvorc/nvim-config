-- https://github.com/echasnovski/mini.diff
-- Work with diff hunks.
return {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  version = false,
  keys = {
    {
      "<leader>gD",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
      desc = "Diff Hunks",
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
      -- Apply hunks inside a visual/operator region
      apply = "<leader>h",

      -- Reset hunks inside a visual/operator region
      reset = "<leader>H",

      -- Hunk range textobject to be used inside operator
      -- Works also in Visual mode if mapping differs from apply and reset
      textobject = "<leader>h",
    },
  },
  config = function(_, opts)
    require("mini.diff").setup(opts)
  end,
}
