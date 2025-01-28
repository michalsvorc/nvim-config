-- https://github.com/monkoose/neocodeium
-- AI completion powered by Codeium.

local cmp = require("modules.cmp")

return {
  {
    "monkoose/neocodeium",
    version = false,
    event = "LazyFile",
    opts = {
      silent = true,
      manual = true,
      filetypes = {
        gitcommit = true,
        gitrebase = false,
        help = false,
        ["."] = false,
      },
    },


    -- stylua: ignore
    keys = {
      { "<C-l>", function() require("neocodeium").accept() end, mode = "i" },
      { "<C-i>", function() require("neocodeium").accept_line() end, mode = "i" },
      { "<C-o>", function() require("neocodeium").accept_word() end, mode = "i" },
      { "<C-j>",
        function()
          require("neocodeium").cycle_or_complete(1)
          cmp.menu_hide()
        end,
        mode = "i"
      },
      {
        "<C-k>",
        function()
          require("neocodeium").cycle_or_complete(-1)
          cmp.menu_hide()
        end,
        mode = "i",
      },
      { "<C-h>", function() require("neocodeium").clear() end, mode = "i" },
    },
    config = function(_, opts)
      require("neocodeium").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = cmp.events.menu_open,
        callback = function()
          require("neocodeium").clear()
        end,
      })
    end,
  },
}
