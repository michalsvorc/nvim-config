--[[
Copyright 2024 https://github.com/folke

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Source: https://github.com/LazyVim/LazyVim/blob/v14.6.0/lua/lazyvim/plugins/extras/lang/python.lua

Added:
  - ensure_installed for python in nvim-treesitter
  - ensure_installed for lsp and ruff in mason
Removed:
  - lazyvim_docs check for global lsp and ruff values
  - recommended function
  - neovim/nvim-lspconfig
  - ruff_lsp settings (old LSP implementation)
  - hrsh7th/nvim-cmp optional flag
  - plugins:
    * neovim/nvim-lspconfig (enable servers loop)
    * nvim-neotest/neotest
    * mfussenegger/nvim-dap
    * linux-cultist/venv-selector.nvim
    * jay-babu/mason-nvim-dap.nvim
--]]

local lsp = "pyright"
local ruff = "ruff"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python", "ninja", "rst" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { lsp, ruff } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
      },
      setup = {
        [ruff] = function()
          LazyVim.lsp.on_attach(function(client, _)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end, ruff)
        end,
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
    end,
  },
}
