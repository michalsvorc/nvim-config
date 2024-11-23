local M = {}

---Get the content of the buffer
---@param bufnr? integer
---@return string
M.get_buffer_content = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.cmd([[normal! ggV]])
  vim.fn.feedkeys("G")
  local selected_text = vim.fn.getreg("*")
  return selected_text
end

return M
