-- https://github.com/zbirenbaum/copilot.lua
-- Fully featured & enhanced replacement for copilot.vim
-- complete with API for interacting with Github Copilot.
return {
  {
    "zbirenbaum/copilot.lua",
    event = "LazyFile",
    version = false,
    keys = {
      { "<LocalLeader>s", "<cmd>Copilot panel<cr>", mode = { "n", "v" }, desc = "Suggestion panel" },
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
        debounce = 75,
        keymap = {
          accept = "<A-i>",
          accept_line = "<A-l>",
          accept_word = "<A-h>",
          next = "<A-j>",
          prev = "<A-k>",
          dismiss = "<A-c>",
        },
      },
      filetypes = {
        markdown = true,
        gitcommit = true,
        gitrebase = false,
        ["."] = false,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)

      local fg_color = vim.api.nvim_get_hl_by_name("Include", true).foreground
      vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = fg_color })
      vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = fg_color })

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
