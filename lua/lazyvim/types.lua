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

Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/types.lua
--]]

---@meta

---@class LazyVimGlobals
vim.g = {}

_G.lazyvim_docs = true
_G.LazyVim = require("lazyvim.util")

---@class vim.api.create_autocmd.callback.args
---@field id number
---@field event string
---@field group number?
---@field match string
---@field buf number
---@field file string
---@field data any

---@class vim.api.keyset.create_autocmd.opts: vim.api.keyset.create_autocmd
---@field callback? fun(ev:vim.api.create_autocmd.callback.args):boolean?

--- @param event any (string|array) Event(s) that will trigger the handler
--- @param opts vim.api.keyset.create_autocmd.opts
--- @return integer
function vim.api.nvim_create_autocmd(event, opts) end
