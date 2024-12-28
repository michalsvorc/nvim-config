local M = {}

M.window_is_open = false

M.add_current_entry = function()
  local m_content = require("modules.content")
  local entry = m_content.get_entry()
  local qflist = vim.fn.getqflist()

  if not qflist or type(qflist) ~= "table" then
    qflist = {}
  end

  table.insert(qflist, entry)
  vim.fn.setqflist(qflist, "r")
end

M.edit_all_entries = function()
  local qflist = vim.fn.getqflist()
  if vim.tbl_isempty(qflist) then
    return
  end

  local prev_val = ""
  for _, d in ipairs(qflist) do
    local curr_val = vim.fn.bufname(d.bufnr)
    if curr_val ~= prev_val then
      vim.cmd("edit " .. curr_val)
    end
    prev_val = curr_val
  end
end

M.toggle_window = function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      M.window_is_open = true
      break
    end
  end
  if M.window_is_open == true then
    vim.cmd("cclose")
    return
  end
  vim.cmd("copen")
end

return M
