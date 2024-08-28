-- https://github.com/folke/todo-comments.nvim
-- Highlight, list and search todo comments in your projects.
return {
  "folke/todo-comments.nvim",
  version = false,
  dependencies = { "nvim-lua/plenary.nvim", lazy = true },
  event = "LazyFile",
  opts = {},
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next Todo Comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous Todo Comment",
    },
    {
      "<leader>st",
      function()
        require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } })
      end,
      desc = "Todo/Fix",
    },
    {
      "<leader>sT",
      function()
        require("todo-comments.fzf").todo()
      end,
      desc = "Todo (all keywords)",
    },
  },
}
