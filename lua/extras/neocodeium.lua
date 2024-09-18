-- https://github.com/monkoose/neocodeium
-- AI completion powered by Codeium.
local opts = {
  silent = true,
  filetypes = {
    gitcommit = true,
    gitrebase = false,
    help = false,
    ["."] = false,
  },
}

return {
  {
    "monkoose/neocodeium",
    event = "LazyFile",
    version = false,
    opts = opts,
    -- stylua: ignore
    keys = {
      { "<A-f>", function() require("neocodeium").accept() end, mode = "i" },
      { "<A-w>", function() require("neocodeium").accept_word() end, mode = "i" },
      { "<A-a>", function() require("neocodeium").accept_line() end, mode = "i" },
      { "<A-e>", function() require("neocodeium").cycle_or_complete() end, mode = "i" },
      { "<A-r>", function() require("neocodeium").cycle_or_complete(-1) end, mode = "i" },
      { "<A-c>", function() require("neocodeium").clear() end, mode = "i" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = {
      completion = {
        autocomplete = false,
      },
    },
    config = function(_, cmp_opts)
      -- Using alongside nvim-cmp
      -- Source: https://github.com/monkoose/neocodeium
      local cmp = require("cmp")
      local neocodeium = require("neocodeium")

      ---@diagnostic disable-next-line: undefined-field
      cmp.event:on("menu_opened", function()
        neocodeium.clear()
      end)

      ---@diagnostic disable-next-line: undefined-field
      neocodeium.setup(LazyVim.merge(opts, {
        filter = function()
          return not cmp.visible()
        end,
      }))

      cmp.setup(cmp_opts)
    end,
  },
}
