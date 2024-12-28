local M = {}

--- Returns the content of the buffer.
--- @param bufnr? integer The buffer number. Default is the current buffer.
--- @return string The content of the buffer.
M.get_buffer = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.cmd([[normal! ggV]])
  vim.fn.feedkeys("G")
  local selected_text = vim.fn.getreg("*")
  return selected_text
end

--- Get the selected text in visual mode.
--- @return string The selected text.
M.get_selected = function()
  local mode = vim.api.nvim_get_mode().mode
  local opts = {}
  -- \22 is an escaped version of <c-v>
  if mode == "v" or mode == "V" or mode == "\22" then
    opts.type = mode
  end
  return vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), opts)
end

--- Returns the current entry in the buffer.
--- @return { filename: string, lnum: integer, col: integer, text: string }
M.get_entry = function()
  local file = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local text = vim.fn.getline(".")
  return {
    filename = file,
    lnum = line,
    col = col,
    text = text,
  }
end

return M
