-- https://github.com/cbochs/grapple.nvim
-- Tagging important files.
return {
  "cbochs/grapple.nvim",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "echasnovski/mini.icons" }, -- 'nvim-tree/nvim-web-devicons' mock
  opts = {
    scope = "git",
    icons = true,
    quick_select = "asdfgqwerty",
    default_scopes = { lsp = false },
    prune = "180d",
    win_opts = {
      width = 0.5,
      height = 0.35,
      row = 0.5,
      col = 0.5,
      relative = "editor",
      focusable = false,
      style = "minimal",
      title = "Marked files",
    },
  },
  cmd = "Grapple",
  keys = {
    {
      "<leader>M",
      function()
        vim.cmd("Grapple toggle")
        print("Toggled marked file")
      end,
      desc = "Marked file toggle",
    },
    { "<leader>m", "<cmd>Grapple toggle_tags<cr>", desc = "Marked files" },
    { "]\\", "<cmd>Grapple cycle_tags next<cr>", desc = "Next marked file" },
    { "[\\", "<cmd>Grapple cycle_tags prev<cr>", desc = "Previous marked file" },
  },
}
