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

Source: https://github.com/LazyVim/LazyVim/blob/v14.6.0/lua/lazyvim/plugins/extras/formatting/prettier.lua

Changed:
  - "stevearc/conform.nvim" remove optional flag
Removed:
  - lazyvim_docs conditional to set lazyvim_prettier_needs_config
  - none-ls support
--]]

-- https://github.com/prettier/prettier
-- Opinionated code formatter.

---@alias ConformCtx {buf: number, filename: string, dirname: string}
local M = {}

local supported = {
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

--- Checks if a Prettier config file exists for the given context
---@param ctx ConformCtx
function M.has_config(ctx)
  vim.fn.system({ "prettier", "--find-config-path", ctx.filename })
  return vim.v.shell_error == 0
end

--- Checks if a parser can be inferred for the given context:
--- * If the filetype is in the supported list, return true
--- * Otherwise, check if a parser can be inferred
---@param ctx ConformCtx
function M.has_parser(ctx)
  local ft = vim.bo[ctx.buf].filetype --[[@as string]]
  -- default filetypes are always supported
  if vim.tbl_contains(supported, ft) then
    return true
  end
  -- otherwise, check if a parser can be inferred
  local ret = vim.fn.system({ "prettier", "--file-info", ctx.filename })
  ---@type boolean, string?
  local ok, parser = pcall(function()
    return vim.fn.json_decode(ret).inferredParser
  end)
  return ok and parser and parser ~= vim.NIL
end

M.has_config = LazyVim.memoize(M.has_config)
M.has_parser = LazyVim.memoize(M.has_parser)

return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "prettier" } },
  },
  {
    "stevearc/conform.nvim",
    ---@param opts ConformOpts
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(supported) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], "prettier")
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = {
        condition = function(_, ctx)
          return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
        end,
      }
    end,
  },
}
