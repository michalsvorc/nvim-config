-- https://github.com/olimorris/codecompanion.nvim
-- AI-powered coding, seamlessly in Neovim.
--
-- config: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
-- keymaps: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua#L108
-- TODO: keymaps

local adapter_openai = "openai"
local picker = "fzf_lua"
local get_api_key = require("functions.api_key").get_api_key

return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    adapters = {
      openai = function()
        return require("codecompanion.adapters").extend(adapter_openai, {
          env = {
            api_key = get_api_key(vim.g.api_key_openai_path),
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = adapter_openai,

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
        adapter = adapter_openai,
      },
      agent = {
        adapter = adapter_openai,
      },
    },
    display = {
      chat = {
        start_in_insert_mode = true,
        diff = {
          provider = "mini_diff",
        },
      },
    },
  },
  keys = {
    { "<LocalLeader>\\", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" } },
    { "<LocalLeader>a", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" } },
    { "<LocalLeader>A", "<cmd>CodeCompanionChat Add<cr>", mode = "v" },
  },
  config = true,
}
