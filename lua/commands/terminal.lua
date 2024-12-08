local function open_path_of_current_buffer()
  local file_path = vim.fn.expand("%:p:h")
  vim.cmd("cd " .. file_path)
  vim.cmd("term")
end

vim.api.nvim_create_user_command("TermCurrentBuffer", open_path_of_current_buffer, { nargs = 0 })
