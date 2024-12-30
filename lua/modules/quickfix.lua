local M = {}

--- Checks if the quickfix window is currently open.
--- @return boolean True if the quickfix window is open, false otherwise.
M.is_window_open = function()
  local windows = vim.fn.getwininfo()
  for _, win in ipairs(windows) do
    if win.quickfix == 1 then
      return true
    end
  end
  return false
end

--- Determines if the cursor is inside the quickfix window.
--- @return boolean True if the cursor is in a quickfix window, false otherwise.
M.is_cursor_inside_window = function()
  if vim.bo.buftype ~= "quickfix" then
    return false
  end

  return true
end

--- Adds the current position from the buffer to the quickfix list.
--- If the cursor is inside the quickfix window, a warning is displayed.
M.add_current_position = function()
  if M.is_cursor_inside_window() == true then
    vim.notify("Move out of quickfix window.", vim.log.levels.WARN)
    return
  end

  local m_content = require("modules.content")
  local entry = m_content.get_entry()
  local qf_list = vim.fn.getqflist()

  if not qf_list or type(qf_list) ~= "table" then
    qf_list = {}
  end

  table.insert(qf_list, entry)
  vim.fn.setqflist(qf_list, "r")
end

--- Removes the current entry from the quickfix list.
--- If not in a quickfix window or the current entry is invalid, a notification is displayed.
M.remove_entry = function()
  if M.is_cursor_inside_window() == false then
    vim.notify("Not in a quickfix window.", vim.log.levels.WARN)
    return
  end

  local qf_list = vim.fn.getqflist()
  local current_index = vim.fn.line(".")

  if current_index < 1 or current_index > #qf_list then
    vim.notify("Invalid current entry.", vim.log.levels.ERROR)
    return
  end

  table.remove(qf_list, current_index)

  vim.fn.setqflist(qf_list, "r")
end

--- Iterates through the quickfix list and opens each buffer.
M.edit_all_entries = function()
  if M.is_cursor_inside_window() == false then
    return
  end

  local qf_list = vim.fn.getqflist()
  if vim.tbl_isempty(qf_list) then
    return
  end

  local prev_val = ""
  for _, d in ipairs(qf_list) do
    local curr_val = vim.fn.bufname(d.bufnr)
    if curr_val ~= prev_val then
      vim.cmd("edit " .. curr_val)
    end
    prev_val = curr_val
  end
end

--- Toggles the visibility of the quickfix window.
M.toggle_window = function()
  local is_window_open = M.is_window_open()

  if is_window_open then
    vim.cmd("cclose")
    return
  end

  vim.cmd("copen")
end

return M
