-- https://github.com/stevearc/oil.nvim
-- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.

-- Show CWD in the winbar
-- https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#show-cwd-in-the-winbar
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

local column_details_toggle = true
local column_details_minimal = { "icon" }
local column_details_full = { "icon", "permissions", "size", "mtime" }

local toggle_detailed_view = {
  desc = "Toggle file detail view",
  callback = function()
    column_details_toggle = not column_details_toggle
    if column_details_toggle then
      require("oil").set_columns(column_details_full)
    else
      require("oil").set_columns(column_details_minimal)
    end
  end,
}

local function toggle_explorer()
  local oil = require("oil")
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  if bufname:match("^oil://") then
    oil.close()
  else
    oil.open()
  end
end

return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = column_details_minimal,
      delete_to_trash = false,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
      },
      keymaps = {
        ["gs"] = toggle_detailed_view,
        ["gS"] = "actions.change_sort",
        ["<C-q>"] = "actions.send_to_qflist",
        ["<A-q>"] = "actions.add_to_qflist",
        ["="] = "actions.preview",
      },
    })
  end,
  keys = {
    { "<leader>e", toggle_explorer, desc = "File Explorer" },
  },
}
