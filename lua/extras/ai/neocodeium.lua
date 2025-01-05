-- https://github.com/monkoose/neocodeium
-- AI completion powered by Codeium.

return {
  {
    "monkoose/neocodeium",
    version = false,
    event = "LazyFile",
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
      { "<C-i>", function() require("neocodeium").accept() end, mode = "i" },
      { "<C-l>", function() require("neocodeium").accept_line() end, mode = "i" },
      { "<C-h>", function() require("neocodeium").accept_word() end, mode = "i" },
      { "<C-j>", function() require("neocodeium").cycle_or_complete() end, mode = "i" },
      { "<C-k>", function() require("neocodeium").cycle_or_complete(-1) end, mode = "i" },
      { "<C-c>", function() require("neocodeium").clear() end, mode = "i" },
    },
        end,
      },
    },
    config = function(_, opts)
      local neocodeium = require("neocodeium")

    end,
  },
}
