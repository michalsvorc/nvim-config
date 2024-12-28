local m_buffer = require("modules.buffer")

local function messages_to_buffer()
  m_buffer.create_temp_buffer()
  local messages = vim.fn.execute("messages")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(messages, "\n"))
end

vim.api.nvim_create_user_command("BufferizeMessages", messages_to_buffer, { nargs = 0 })
