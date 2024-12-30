local M = {}

--- Creates a new temporary buffer.
M.create_temp_buffer = function()
  vim.cmd("enew")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
  vim.bo.swapfile = false
end

return M
