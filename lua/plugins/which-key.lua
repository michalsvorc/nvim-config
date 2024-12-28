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

Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua
Removed:
  - keys:
    * git hunks
Added:
  - keys:
    * git stash
Changed:
  - split to a separate module
  - remove `config` function
  - keys:
    * Buffer Keymaps (which-key)
--]]

-- Repository: https://github.com/folke/which-key.nvim
-- Description:
-- WhichKey helps you remember your Neovim keymaps,
-- by showing available keybindings in a popup as you type.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    defaults = {},
    spec = {
      {
        mode = { "n", "v" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>a", group = "ai", icon = { icon = "󰚩 ", color = "orange" } },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git", icon = { icon = "󰊢 ", color = "orange" } },
        { "<leader>gs", group = "stash" },
        { "<leader>h", group = "hunks", icon = { icon = "󰊢 ", color = "orange" } },
        { "<leader>q", group = "quickfix" },
        { "<leader>r", group = "refactor", icon = { icon = " ", color = "orange" } },
        { "<leader>s", group = "search" },
        { "<leader>t", group = "terminal", icon = { icon = "", color = "red" } },
        { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<leader>y", group = "yank" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
        {
          "<leader>b",
          group = "buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          "<leader>w",
          group = "windows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },
  keys = {
    {
      "<leader>b?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps (which-key)",
    },
    {
      "<c-w><space>",
      function()
        require("which-key").show({ keys = "<c-w>", loop = true })
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
}
