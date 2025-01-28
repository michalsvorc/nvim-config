-- https://github.com/zbirenbaum/copilot.lua
-- Fully featured & enhanced replacement for copilot.vim
-- complete with API for interacting with Github Copilot.

local cmp = require("modules.cmp")

return {
  {
    "zbirenbaum/copilot.lua",
    version = false,
    event = "LazyFile",
    opts = {
      panel = {
        layout = {
          position = "right",
          ratio = 0.5,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = true,
        debounce = 25,
        -- stylua: ignore
        keymap = {
          accept =      "<C-l>",
          accept_line = "<C-i>",
          accept_word = "<C-o>",
          dismiss =     "<C-h>",
        },
      },
      filetypes = {
        markdown = true,
        gitcommit = true,
        gitrebase = false,
        codecompanion = true,
        ["."] = false,
      },
    },
    keys = {
      { "<LocalLeader>s", "<cmd>Copilot panel<cr>", mode = { "n", "v" }, desc = "Suggestions panel" },
      { "<LocalLeader>S", "<cmd>set buflisted | Copilot toggle<cr>", mode = { "n", "v" }, desc = "Suggestions toggle" },
      { "<LocalLeader>p", "<cmd>Copilot! attach<cr>", mode = { "n", "v" }, desc = "Copilot attach" },
      {
        "<C-j>",
        function()
          require("copilot.suggestion").next()
          cmp.menu_hide()
        end,
        mode = "i",
      },
      {
        "<C-k>",
        function()
          require("copilot.suggestion").prev()
          cmp.menu_hide()
        end,
        mode = "i",
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)

      vim.api.nvim_set_hl(0, "CopilotSuggestion", { link = "Function" })
      vim.api.nvim_set_hl(0, "CopilotAnnotation", { link = "Function" })

      vim.api.nvim_create_autocmd("User", {
        pattern = cmp.events.menu_open,
        callback = function()
          require("copilot.suggestion").dismiss()
        end,
      })
    end,
  },
}
