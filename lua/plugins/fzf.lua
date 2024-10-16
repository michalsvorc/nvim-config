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
  - setting vim.g.lazyvim_picker
  - folke/todo-comments.nvim plugin
  - folke/trouble.nvim
  - custom LazyVim option to configure vim.ui.select
    fixes picker display for some plugins (CodeCompanion) in visual mode
  - code actions previewer
  - keys:
    * Switch Buffer
Changed:
  - stylua formatting
  - path to LSP keymaps
  - window dimensions
  - use live_grep_glob for grep commands
  - fzf layout
  - disabled init function to configure vim.ui.select
  - keys:
    * grep actions
    * jumplist
Added:
  - buffer picker
  - keys:
    * search quickfix
    * search git objects
    * search current buffer
    * lsp actions
    * Recent files shortcut
--]]

-- https://github.com/ibhagwan/fzf-lua
-- Improved fzf.vim written in lua.
---@class FzfLuaOpts: lazyvim.util.pick.Opts
---@field cmd string?

---@type LazyPicker
local picker = {
  name = "fzf",
  commands = {
    files = "files",
  },

  ---@param command string
  ---@param opts? FzfLuaOpts
  open = function(command, opts)
    opts = opts or {}
    if opts.cmd == nil and command == "git_files" and opts.show_untracked then
      opts.cmd = "git ls-files --exclude-standard --cached --others"
    end
    return require("fzf-lua")[command](opts)
  end,
}
if not LazyVim.pick.register(picker) then
  return {}
end

local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = LazyVim.config.get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

return {
  desc = "Awesome picker for FZF (alternative to Telescope)",
  recommended = true,
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function(_, opts)
      local config = require("fzf-lua.config")
      local actions = require("fzf-lua.actions")

      -- Quickfix
      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
      config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
      config.defaults.keymap.fzf["ctrl-x"] = "jump"
      config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
      config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
      config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
      config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

      -- Toggle root dir / cwd
      config.defaults.actions.files["ctrl-r"] = function(_, ctx)
        local o = vim.deepcopy(ctx.__call_opts)
        o.root = o.root == false
        o.cwd = nil
        o.buf = ctx.__CTX.bufnr
        LazyVim.pick.open(ctx.__INFO.cmd, o)
      end
      config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
      config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

      -- use the same prompt for all
      local defaults = require("fzf-lua.profiles.default-title")
      local function fix(t)
        t.prompt = t.prompt ~= nil and " " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
      end
      fix(defaults)

      local img_previewer ---@type string[]?
      for _, v in ipairs({
        { cmd = "ueberzug", args = {} },
        { cmd = "chafa", args = { "{file}", "--format=symbols" } },
        { cmd = "viu", args = { "-b" } },
      }) do
        if vim.fn.executable(v.cmd) == 1 then
          img_previewer = vim.list_extend({ v.cmd }, v.args)
          break
        end
      end

      return vim.tbl_deep_extend("force", defaults, {
        fzf_colors = true,
        fzf_opts = {
          ["--layout"] = "default",
          ["--no-scrollbar"] = true,
        },
        defaults = {
          -- formatter = "path.filename_first",
          formatter = "path.dirname_first",
        },
        previewers = {
          builtin = {
            extensions = {
              ["png"] = img_previewer,
              ["jpg"] = img_previewer,
              ["jpeg"] = img_previewer,
              ["gif"] = img_previewer,
              ["webp"] = img_previewer,
            },
            ueberzug_scaler = "fit_contain",
          },
        },
        winopts = {
          width = 1,
          height = 1,
          row = 0.5,
          col = 0.5,
          preview = {
            scrollchars = { "┃", "" },
          },
        },
        files = {
          cwd_prompt = false,
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
          -- allow ripgrep flags in live grep
          -- https://github.com/ibhagwan/fzf-lua/wiki#how-can-i-send-custom-flags-to-ripgrep-with-live_grep
          rg_glob = true,
          rg_glob_fn = function(query)
            local regex, flags = query:match("^(.-)%s%-%-(.*)$")
            return (regex or query), flags
          end,
        },
        lsp = {
          symbols = {
            symbol_hl = function(s)
              return "TroubleIcon" .. s
            end,
            symbol_fmt = function(s)
              return s:lower() .. "\t"
            end,
            child_prefix = false,
          },
          code_actions = {
            winopts = require("config.fzf").winopts.small_window,
          },
        },
      })
    end,
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
    -- stylua: ignore
    keys = {
      { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
      { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
      -- quick keys
      { "<leader><", function() require("fzf-lua").buffers({ sort_mru = true, sort_lastused = true, winopts = require("config.fzf").winopts.small_window, }) end, desc = "Buffers", },
      { "<leader>.", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>>", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
      { "<leader>?", LazyVim.pick("grep_cword"), mode = "n", desc = "Grep Word (Root Dir)" },
      { "<leader>?", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>/", LazyVim.pick("live_grep_glob"), desc = "Grep (Root Dir)" },
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
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
      { "<leader>sg", LazyVim.pick("live_grep_glob"), desc = "Grep (Root Dir)" },
      { "<leader>sG", LazyVim.pick("live_grep_glob", { root = false }), desc = "Grep (cwd)" },
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
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gl", "<cmd>FzfLua lsp_finder<cr>",                                                               desc = "LSP Finder" },
        { "gd", "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>",  desc = "LSP Definition", has = "definition" },
        { "gD", "<cmd>FzfLua lsp_declarations    jump_to_single_result=true ignore_current_line=true<cr>",  desc = "LSP Declaration", has = "declaration" },
        { "gr", "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>",  desc = "LSP References", nowait = true },
        { "gI", "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",  desc = "LSP Implementation" },
        { "gt", "<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>",  desc = "LSP Type Definition" },
        { "ga", "<cmd>FzfLua lsp_incoming_calls  jump_to_single_result=false<cr>",                          desc = "LSP Incoming Calls", has = "callHierarchy/incomingCalls" },
        { "gA", "<cmd>FzfLua lsp_outgoing_calls  jump_to_single_result=false<cr>",                          desc = "LSP Outgoing Calls", has = "callHierarchy/outgoingCalls" },
        -- shortcuts
        { "<leader>l", "<cmd>FzfLua lsp_finder<cr>",                                                               desc = "LSP Finder" },
      })
    end,
  },
}
