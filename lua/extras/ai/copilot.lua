-- https://github.com/zbirenbaum/copilot.lua
-- Fully featured & enhanced replacement for copilot.vim
-- complete with API for interacting with Github Copilot.

return {
  {
    "zbirenbaum/copilot.lua",
    version = false,
    event = "LazyFile",
    keys = {
      { "<LocalLeader>s", "<cmd>Copilot panel<cr>", mode = { "n", "v" }, desc = "Suggestions panel" },
      { "<LocalLeader>S", "<cmd>set buflisted | Copilot toggle<cr>", mode = { "n", "v" }, desc = "Suggestions toggle" },
      { "<LocalLeader>p", "<cmd>Copilot! attach<cr>", mode = { "n", "v" }, desc = "Copilot attach" },
    },
    opts = {
      panel = {
        layout = {
          position = "right",
          ratio = 0.5,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 25,
        -- stylua: ignore
        keymap = {
          accept =      "<C-i>",
          accept_line = "<C-l>",
          accept_word = "<C-h>",
          next =        "<C-j>",
          prev =        "<C-k>",
          dismiss =     "<C-c>",
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
    config = function(_, opts)
      require("copilot").setup(opts)

      vim.api.nvim_set_hl(0, "CopilotSuggestion", { link = "Function" })
      vim.api.nvim_set_hl(0, "CopilotAnnotation", { link = "Function" })

      -- cmp menu override
      -- https://github.com/zbirenbaum/copilot.lua?tab=readme-ov-file#suggestion
      local cmp = require("cmp")

      ---@diagnostic disable-next-line: undefined-field
      cmp.event:on("menu_opened", function()
        vim.b.copilot_suggestion_hidden = true
      end)

      ---@diagnostic disable-next-line: undefined-field
      cmp.event:on("menu_closed", function()
        vim.b.copilot_suggestion_hidden = false
      end)
    end,
  },
}
