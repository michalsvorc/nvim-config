-- https://github.com/monkoose/neocodeium
-- AI completion powered by Codeium.
return {
  {
    "monkoose/neocodeium",
    event = "LazyFile",
    version = false,
    opts = {
      silent = true,
      filetypes = {
        gitcommit = true,
        gitrebase = false,
        help = false,
        ["."] = false,
      },
    },
    -- stylua: ignore
    keys = {
      { "<A-f>", function() require("neocodeium").accept() end, mode = "i" },
      { "<A-w>", function() require("neocodeium").accept_word() end, mode = "i" },
      { "<A-a>", function() require("neocodeium").accept_line() end, mode = "i" },
      { "<A-e>", function() require("neocodeium").cycle_or_complete() end, mode = "i" },
      { "<A-r>", function() require("neocodeium").cycle_or_complete(-1) end, mode = "i" },
      { "<A-c>", function() require("neocodeium").clear() end, mode = "i" },
    },
    config = function(_, opts)
      -- Using neocodeium alongside nvim-cmp
      -- Source: https://github.com/monkoose/neocodeium
      local cmp = require("cmp")

      ---@diagnostic disable-next-line: undefined-field
      require("neocodeium").setup(LazyVim.merge(opts, {
        filter = function()
          return not cmp.visible()
        end,
      }))
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = {
      completion = {
        autocomplete = false,
      },
    },
    config = function(_, opts)
      local cmp = require("cmp")
      local neocodeium = require("neocodeium")

      ---@diagnostic disable-next-line: undefined-field
      cmp.event:on("menu_opened", function()
        neocodeium.clear()
      end)

      cmp.setup(opts)
    end,
  },
}
