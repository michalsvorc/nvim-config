local m_quickfix = require("modules.quickfix")

local quickfix_commands = {
  add_current_position = m_quickfix.add_current_position,
  edit_all_entries = m_quickfix.edit_all_entries,
  remove_entry = m_quickfix.remove_entry,
  toggle_window = m_quickfix.toggle_window,
}

local function main(opts)
  local subcommand = opts.args
  local command = quickfix_commands[subcommand]
  if command then
    command()
  else
    vim.notify("Invalid Quickfix command: " .. subcommand, vim.log.levels.ERROR)
  end
end

local function complete()
  local keys = vim.tbl_keys(quickfix_commands)
  table.sort(keys)
  return keys
end

vim.api.nvim_create_user_command("Quickfix", main, {
  nargs = 1,
  complete = complete,
})
