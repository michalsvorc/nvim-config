vim.api.nvim_create_user_command("BuffMessages", function()
  -- Create a new buffer
  vim.cmd("enew")

  -- Set the buffer as a temporary buffer
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
  vim.bo.swapfile = false

  -- Populate the buffer with the output of :messages
  local messages = vim.fn.execute("messages")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(messages, "\n"))
end, {})
