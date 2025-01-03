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

Source: https://github.com/LazyVim/LazyVim/blob/v14.6.0/lua/lazyvim/plugins/init.lua

Added:
  - LazyVim options setup
Removed:
  - vim version check
  - hack for vim.notify after snacks setup
--]]

-- Options defaults:
-- https://github.com/LazyVim/LazyVim/blob/v14.6.0/lua/lazyvim/config/init.lua#L10
local lazyvim_options = {
  colorscheme = "catppuccin",
  defaults = {
    autocmds = true,
    keymaps = false,
  },
  news = {
    lazyvim = false,
    neovim = false,
  },
}

require("lazyvim.config").init()

return {
  { "folke/lazy.nvim", version = "*" },
  {
    "LazyVim/LazyVim",
    priority = 10000,
    lazy = false,
    opts = {},
    cond = true,
    config = function()
      require(".lazyvim").setup(lazyvim_options)
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
  },
}
