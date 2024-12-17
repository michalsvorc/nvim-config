--[[
MIT License
Copyright (c) 2021 iBhagwan
https://github.com/ibhagwan/fzf-lua/blob/main/LICENSE

Source:
https://github.com/ibhagwan/fzf-lua/blob/e2f7165788ab36431680867d087d093470cc236e/lua/fzf-lua/providers/nvim.lua#L222

Changed:
  - filters by pattern
  - predefined query to show project marks
--]]

local fzf = require("fzf-lua")
local config = fzf.config
local core = fzf.core
local path = fzf.path
local utils = fzf.utils

fzf.marks_global = function(opts)
  opts = config.normalize_opts(opts, "marks")
  if not opts then
    return
  end

  local marks = vim.fn.execute("marks")
  marks = vim.split(marks, "\n")

  local entries = {}
  local pattern = opts.marks or "[A-Za-z]"
  local project_root = require("modules.path").get_project_root()

  for i = #marks, 3, -1 do
    local mark, line, col, text = marks[i]:match("(.)%s+(%d+)%s+(%d+)%s+(.*)")
    if mark and string.match(mark, pattern) then
      col = tostring(tonumber(col) + 1)
      if text:sub(1, #project_root) == project_root then
        text = text:sub(#project_root + 2) -- Remove project root and the following '/'
      elseif path.is_absolute(text) then
        text = path.HOME_to_tilde(text)
      end

      table.insert(
        entries,
        string.format(
          " %-15s %15s %15s %s",
          utils.ansi_codes.yellow(mark),
          utils.ansi_codes.blue(line),
          utils.ansi_codes.green(col),
          text
        )
      )
    end
  end

  table.sort(entries, function(a, b)
    return a < b
  end)
  table.insert(entries, 1, string.format("%-5s %s  %s %s", "mark", "line", "col", "file/text"))

  opts.fzf_opts["--header-lines"] = 1
  opts.fzf_opts["--query"] = "!~ "
  core.fzf_exec(entries, opts)
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>m",
  "<cmd>:lua require('fzf-lua').marks_global()<CR>",
  { noremap = true, silent = true, desc = "Marks (Project)" }
)
