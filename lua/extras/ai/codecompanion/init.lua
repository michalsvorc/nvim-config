-- https://github.com/olimorris/codecompanion.nvim
-- AI-powered coding, seamlessly in Neovim.
--
-- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua

local adapter = vim.g.codecompanion_adapter
local openai_model = vim.g.openai_model
local picker = "fzf_lua"
local prompts = require("extras/ai/codecompanion/prompts")
local get_api_key = require("modules.api_key").get_api_key

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" }, -- https://github.com/olimorris/codecompanion.nvim/tree/v10.7.0?tab=readme-ov-file#package-installation see Pinned plugins
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.diff",
  },
  opts = {
    adapters = {
      openai = function()
        if adapter ~= "openai" then
          return {}
        end

        local api_key = get_api_key(vim.g.api_key_openai_path)
        local options = {
          env = {
            api_key = api_key,
          },
          schema = {
            model = {
              default = openai_model,
            },
          },
        }

        return require("codecompanion.adapters").extend(adapter, options)
      end,
    },
    strategies = {
      chat = {
        adapter = adapter,
        slash_commands = {
          ["buffer"] = {
            opts = {
              provider = picker,
            },
          },
          ["file"] = {
            opts = {
              provider = picker,
            },
          },
        },
      },
      inline = {
        adapter = adapter,
      },
    },
    display = {
      chat = {
        start_in_insert_mode = true,
        diff = {
          provider = "mini_diff",
        },
        window = {
          layout = "buffer", -- float|vertical|horizontal|buffer
        },
      },
    },
    prompt_library = prompts,
  },
  -- stylua: ignore
  keys = {
    { "<LocalLeader>\\", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "Chat" },
    { "<LocalLeader>v", "<cmd>vsplit | CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Chat (vsplit)" },
    { "<LocalLeader>a", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Actions" },
    { "<LocalLeader>A", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Chat" },
    { "<LocalLeader>c", function() require("codecompanion").prompt("commit") end, mode = "v", desc = "Commit message" },
    { "<LocalLeader>d", function() require("codecompanion").prompt("lsp") end, mode = "v", desc = "Diagnostics" },
    { "<LocalLeader>e", function() require("codecompanion").prompt("explain") end, mode = "v", desc = "Explain" },
    { "<LocalLeader>f", function() require("codecompanion").prompt("fix") end, mode = "v", desc = "Fix" },
    { "<LocalLeader>r", function() require("codecompanion").prompt("refactor") end, mode = "v", desc = "Refactor" },
    { "<LocalLeader>t", function() require("codecompanion").prompt("tests") end, mode = "v", desc = "Unit tests" },
  },
}
