-- https://github.com/olimorris/codecompanion.nvim
-- AI-powered coding, seamlessly in Neovim.
--
-- config: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
-- keymaps: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua#L108
-- TODO: keymaps

local adapter = "openai"
local picker = "fzf_lua"
local get_api_key = require("functions.api_key").get_api_key

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
        return require("codecompanion.adapters").extend(adapter, {
          env = {
            api_key = get_api_key(vim.g.api_key_openai_path),
          },
        })
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
