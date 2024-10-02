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

Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/aerial.lua
Added:
  - quick keys
Removed:
  - telescope integration
  - edgy integration
  - lualine integration
  - trouble setup
Changed:
  - window layout
--]]

-- https://github.com/stevearc/aerial.nvim
-- A code outline window for skimming and quick navigation.
return {
  "stevearc/aerial.nvim",
  desc = "Aerial Symbol Browser",
  event = "LazyFile",
  opts = function()
    local icons = vim.deepcopy(LazyVim.config.icons.kinds)

    -- HACK: fix lua's weird choice for `Package` for control
    -- structures like if/else/for/etc.
    icons.lua = { Package = icons.Control }

    ---@type table<string, string[]>|false
    local filter_kind = false
    if LazyVim.config.kind_filter then
      filter_kind = assert(vim.deepcopy(LazyVim.config.kind_filter))
      filter_kind._ = filter_kind.default
      filter_kind.default = nil
    end

    local opts = {
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      show_guides = true,
      layout = {
        resize_to_content = false,
        win_opts = {
          winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
          signcolumn = "yes",
          statuscolumn = " ",
        },
        width = nil,
        max_width = 0.33,
        min_width = 0.15,
      },
      icons = icons,
      filter_kind = filter_kind,
        -- stylua: ignore
        guides = {
          mid_item   = "├╴",
          last_item  = "└╴",
          nested_top = "│ ",
          whitespace = "  ",
        },
    }
    return opts
  end,
  keys = {
    { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Symbols" },
    -- quick keys
    { "<leader>4", "<cmd>AerialToggle<cr>", desc = "Symbols" },
  },
}
