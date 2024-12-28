local function quickfix_add_current()
  local file = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local text = vim.fn.getline(".")
  local entry = {
    filename = file,
    lnum = line,
    col = col,
    text = text,
  }
  local qflist = vim.fn.getqflist()

  if not qflist or type(qflist) ~= "table" then
    qflist = {}
  end

  table.insert(qflist, entry)
  vim.fn.setqflist(qflist, "r")
end

local function edit_as_buffers()
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

local function toggle_qf_window()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end

vim.api.nvim_create_user_command("QuickfixAddCurrent", quickfix_add_current, { nargs = 0 })
vim.api.nvim_create_user_command("QuickfixEditAsBuffers", edit_as_buffers, { nargs = 0 })
vim.api.nvim_create_user_command("QuickfixToggle", toggle_qf_window, { nargs = 0 })
