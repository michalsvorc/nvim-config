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

Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/pick.lua
--]]

---@class lazyvim.util.pick
---@overload fun(command:string, opts?:lazyvim.util.pick.Opts): fun()
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.wrap(...)
  end,
})

---@class lazyvim.util.pick.Opts: table<string, any>
---@field root? boolean
---@field cwd? string
---@field buf? number
---@field show_untracked? boolean

---@class LazyPicker
---@field name string
---@field open fun(command:string, opts?:lazyvim.util.pick.Opts)
---@field commands table<string, string>

---@type LazyPicker?
M.picker = nil

---@param picker LazyPicker
function M.register(picker)
  -- this only happens when using :LazyExtras
  -- so allow to get the full spec
  if vim.v.vim_did_enter == 1 then
    return true
  end

  if M.picker and M.picker.name ~= M.want() then
    M.picker = nil
  end

  if M.picker and M.picker.name ~= picker.name then
    LazyVim.warn(
      "`LazyVim.pick`: picker already set to `" .. M.picker.name .. "`,\nignoring new picker `" .. picker.name .. "`"
    )
    return false
  end
  M.picker = picker
  return true
end

function M.want()
  vim.g.lazyvim_picker = vim.g.lazyvim_picker or "auto"
  if vim.g.lazyvim_picker == "auto" then
    return LazyVim.has_extra("editor.fzf") and "fzf" or "telescope"
  end
  return vim.g.lazyvim_picker
end

---@param command? string
---@param opts? lazyvim.util.pick.Opts
function M.open(command, opts)
  if not M.picker then
    return LazyVim.error("LazyVim.pick: picker not set")
  end

  command = command ~= "auto" and command or "files"
  opts = opts or {}

  opts = vim.deepcopy(opts)

  if type(opts.cwd) == "boolean" then
    LazyVim.warn("LazyVim.pick: opts.cwd should be a string or nil")
    opts.cwd = nil
  end

  if not opts.cwd and opts.root ~= false then
    opts.cwd = LazyVim.root({ buf = opts.buf })
  end

  command = M.picker.commands[command] or command
  M.picker.open(command, opts)
end

---@param command? string
---@param opts? lazyvim.util.pick.Opts
function M.wrap(command, opts)
  opts = opts or {}
  return function()
    LazyVim.pick.open(command, vim.deepcopy(opts))
  end
end

function M.config_files()
  return M.wrap("files", { cwd = vim.fn.stdpath("config") })
end

return M
