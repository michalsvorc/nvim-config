-- https://github.com/olimorris/codecompanion.nvim
-- AI-powered coding, seamlessly in Neovim.
--
-- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua

local adapter = vim.g.codecompanion_adapter
local picker = "fzf_lua"
local prompts = require("extras/ai/codecompanion/prompts")
local get_api_key = require("functions.api_key").get_api_key
local get_buffer_content = require("functions.buffer").get_buffer_content

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      openai = function()
        if adapter ~= "openai" then
          return {}
        end

        local api_key = get_api_key(vim.g.api_key_openai_path)

        local adapter_settings = {
          env = {
            api_key = api_key,
          },
        }

        return require("codecompanion.adapters").extend(adapter, adapter_settings)
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
  keys = {
    { "<LocalLeader>\\", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "Chat" },
    { "<LocalLeader>v", "<cmd>vsplit | CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Chat (vsplit)" },
    { "<LocalLeader>a", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Actions" },
    { "<LocalLeader>A", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Chat" },
    {
      "<LocalLeader>e",
      function()
        local content = get_buffer_content()
        require("codecompanion").prompt("explain", content)
      end,
      mode = "n",
      desc = "Explain",
    },
    {
      "<LocalLeader>e",
      function()
        require("codecompanion").prompt("explain")
      end,
      mode = "v",
      desc = "Explain (selection)",
    },
    {
      "<LocalLeader>f",
      function()
        local content = get_buffer_content()
        require("codecompanion").prompt("fix", content)
      end,
      mode = "n",
      desc = "Fix code",
    },

    {
      "<LocalLeader>f",
      function()
        require("codecompanion").prompt("fix")
      end,
      mode = "v",
      desc = "Fix code (selection)",
    },
    {
      "<LocalLeader>r",
      function()
        local content = get_buffer_content()
        require("codecompanion").prompt("refactor", content)
      end,
      mode = "n",
      desc = "Refactor code",
    },

    {
      "<LocalLeader>r",
      function()
        require("codecompanion").prompt("refactor")
      end,
      mode = "v",
      desc = "Refactor code (selection)",
    },
    {
      "<LocalLeader>c",
      function()
        local content = get_buffer_content()
        require("codecompanion").prompt("commit", content)
      end,
      mode = "n",
      desc = "Generate commit",
    },
    {
      "<LocalLeader>c",
      function()
        require("codecompanion").prompt("commit")
      end,
      mode = "v",
      desc = "Generate commit (selection)",
    },
    {
      "<LocalLeader>d",
      function()
        local content = get_buffer_content()
        require("codecompanion").prompt("lsp", content)
      end,
      mode = "n",
      desc = "Explain diagnostics",
    },
    {
      "<LocalLeader>d",
      function()
        require("codecompanion").prompt("lsp")
      end,
      mode = "v",
      desc = "Explain diagnostics (selection)",
    },
    {
      "<LocalLeader>t",
      function()
        local content = get_buffer_content()
        require("codecompanion").prompt("tests", content)
      end,
      mode = "n",
      desc = "Generate tests",
    },
    {
      "<LocalLeader>t",
      function()
        require("codecompanion").prompt("tests")
      end,
      mode = "v",
      desc = "Generate tests",
    },
  },
  config = true,
}
