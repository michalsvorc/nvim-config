-- https://github.com/stevearc/quicker.nvim
-- Improved UI and workflow for the Neovim quickfix.
---@diagnostic disable: undefined-doc-name
return {
  "stevearc/quicker.nvim",
  event = "FileType qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  keys = {
    {
      "<leader>q",
      function()
        require("quicker").toggle()
      end,
      desc = "Quickfix Toggle",
    },
  },
  config = function(_, opts)
    require("quicker").setup(opts)
  end,
}
