local extras = require("extras.init")

local function handle_extras(action, args)
  local input = args.args
  local config_path = vim.fn.stdpath("config")

  if not extras[input] then
    vim.notify(input .. " is not a valid extra.", vim.log.levels.ERROR)
    return
  end

  local source = config_path .. "/lua/extras/" .. extras[input]
  local target = config_path .. "/lua/plugins/_local/" .. input .. ".lua"

  if action == "enable" then
    os.execute("ln -sfn " .. source .. " " .. target)
    vim.notify("Enabled extra: " .. input, vim.log.levels.INFO)
  elseif action == "disable" then
    if vim.loop.fs_stat(target) then
      os.execute("unlink " .. target)
      vim.notify("Disabled extra: " .. input, vim.log.levels.INFO)
    else
      vim.notify(input .. " is not currently enabled.", vim.log.levels.WARN)
    end
  else
    vim.notify("Invalid action " .. action, vim.log.levels.ERROR)
  end
end

local function extras_enable(args)
  handle_extras("enable", args)
end

local function extras_disable(args)
  handle_extras("disable", args)
end

local function complete()
  local keys = vim.tbl_keys(extras)
  table.sort(keys)
  return keys
end

vim.api.nvim_create_user_command("ExtrasEnable", extras_enable, {
  nargs = 1,
  complete = complete,
})

vim.api.nvim_create_user_command("ExtrasDisable", extras_disable, {
  nargs = 1,
  complete = complete,
})
