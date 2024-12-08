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

Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/fzf.lua

Removed:
  - Switch Buffer
Changed:
  - grep actions
  - jumplist
Added:
  - search quickfix
  - search git objects
  - search current buffer
  - lsp actions
  - Recent files shortcut
--]]

local winopts = require("plugins.fzf.winopts")

local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = LazyVim.config.get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

local M = {}

-- stylua: ignore
M.base = {
  { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
  { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
  -- quick keys
  { "<leader><", function() require("fzf-lua").buffers({ sort_mru = true, sort_lastused = true, winopts = winopts.small_window, }) end, desc = "Buffers", },
  { "<leader>.", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
  { "<leader>>", function() require("fzf-lua").oldfiles({fzf_opts = { ['--query'] = '!~ ' }}) end, desc = "Recent Files (Project)" },
  { "<leader>?", LazyVim.pick("grep_cword"), mode = "n", desc = "Grep Word (Root Dir)" },
  { "<leader>?", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
  { "<leader>/", "<cmd>FzfLua grep_project<cr>", desc = "Grep project" },
  { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
  { "<leader>'", "<cmd>FzfLua marks<cr>", desc = "Marks" },
  { '<leader>"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
  { "<leader>2", "<cmd>FzfLua git_status<cr>", desc = "Git Status" },
  { "<leader>3", "<cmd>FzfLua grep_curbuf<cr>", desc = "Grep Buffer" },
  { "<leader>4", function() require("fzf-lua").lsp_document_symbols({ regex_filter = symbols_filter }) end, desc = "LSP Symbols" },
  { "<leader>5", "<cmd>FzfLua treesitter<cr>", desc = "Treesitter Symbols" },
  -- find
  { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
  { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
  { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
  { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
  { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
  { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
  { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
  -- git
  { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Status" },
  { "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Branches" },
  { "<leader>gC", "<cmd>FzfLua git_commits<cr>", desc = "Commits" },
  { "<leader>g.", "<cmd>FzfLua git_bcommits<cr>", desc = "Buffer Commits" },
  { "<leader>gsa", "<cmd>FzfLua git_stash<cr>", desc = "Stash Apply" },
  { "<leader>gt", "<cmd>FzfLua git_tags<cr>", desc = "Tags" },
  { "<leader>g?", "<cmd>FzfLua git_blame<cr>", desc = "Buffer Blame" },
  -- search
  { "<leader>S", LazyVim.pick("live_grep_glob"), desc = "Grep +glob (Root Dir)" },
  { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
  { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
  { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
  { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
  { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
  { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
  { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
  { "<leader>sg", LazyVim.pick("live_grep_glob"), desc = "Grep +glob (Root Dir)" },
  { "<leader>sG", LazyVim.pick("live_grep_glob", { root = false }), desc = "Grep +glob (cwd)" },
  { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
  { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
  { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
  { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
  { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
  { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
  { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
  { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
  { "<leader>sQ", "<cmd>FzfLua quickfix_stack<cr>", desc = "Quickfix Stack" },
  { "<leader>s.", "<cmd>FzfLua grep_last<cr>", desc = "Repeat Last Grep" },
  { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
  { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
  { "<leader>sw", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
  { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
  { "<leader>uC", LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },
  -- buffer
  { "<leader>bb", function() require("fzf-lua").buffers({ sort_mru = true, sort_lastused = true }) end, desc = "Buffers", },
  -- diagnostics
  { "<leader>d", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
  { "<leader>D", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
  -- code
  { "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", desc = "Code Action", mode = { "n", "v" }},
  --- symbols
  { "<leader>cs", function() require("fzf-lua").lsp_document_symbols({ regex_filter = symbols_filter }) end, desc = "LSP Symbols" },
  { "<leader>cS", function() require("fzf-lua").lsp_live_workspace_symbols({ regex_filter = symbols_filter }) end, desc = "LSP Symbols (Workspace)" },
  { "<leader>ct", "<cmd>FzfLua treesitter<cr>", desc = "Treesitter Symbols" },
  -- other
  { "<leader>j", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
}

-- stylua: ignore
M.lsp = {
  { "<leader>l", "<cmd>FzfLua lsp_finder<cr>",                                                        desc = "LSP Finder" },
  { "gl", "<cmd>FzfLua lsp_finder<cr>",                                                               desc = "LSP Finder" },
  { "gd", "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>",  desc = "LSP Definition", has = "definition" },
  { "gD", "<cmd>FzfLua lsp_declarations    jump_to_single_result=true ignore_current_line=true<cr>",  desc = "LSP Declaration", has = "declaration" },
  { "gr", "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>",  desc = "LSP References", nowait = true },
  { "gI", "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",  desc = "LSP Implementation" },
  { "gt", "<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>",  desc = "LSP Type Definition" },
  { "ga", "<cmd>FzfLua lsp_incoming_calls  jump_to_single_result=false<cr>",                          desc = "LSP Incoming Calls", has = "callHierarchy/incomingCalls" },
  { "gA", "<cmd>FzfLua lsp_outgoing_calls  jump_to_single_result=false<cr>",                          desc = "LSP Outgoing Calls", has = "callHierarchy/outgoingCalls" },
}

return M
