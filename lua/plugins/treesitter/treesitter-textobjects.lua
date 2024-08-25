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

Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
Changed:
  - split to a separate module
--]]

-- Repository: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- Description: Syntax aware text-objects, select, move, swap, and peek support.
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = "VeryLazy",
  enabled = true,
  config = function()
    -- If treesitter is already loaded, we need to run config again for textobjects
    if LazyVim.is_loaded("nvim-treesitter") then
      local opts = LazyVim.opts("nvim-treesitter")
      require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
    end

    -- When in diff mode, we want to use the default
    -- vim text objects c & C instead of the treesitter ones.
    local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
    local configs = require("nvim-treesitter.configs")
    for name, fn in pairs(move) do
      if name:find("goto") == 1 then
        move[name] = function(q, ...)
          if vim.wo.diff then
            local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
            for key, query in pairs(config or {}) do
              if q == query and key:find("[%]%[][cC]") then
                vim.cmd("normal! " .. key)
                return
              end
            end
          end
          return fn(q, ...)
        end
      end
    end
  end,
}
