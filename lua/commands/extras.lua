local extras = require("extras.init")

local function handle_extras(action, args)
  local input = args.args
  local config_path = vim.fn.stdpath("config")

  if not extras[input] then
    print("Error: '" .. input .. "' is not a valid extra.")
    return
  end

  local source = config_path .. "/lua/extras/" .. extras[input]
  local target = config_path .. "/lua/plugins/_local/" .. input .. ".lua"

  if action == "enable" then
    os.execute("ln -sfn " .. source .. " " .. target)
    print("Successfully enabled extra: '" .. input .. "'.")
  elseif action == "disable" then
    if vim.loop.fs_stat(target) then
      os.execute("unlink " .. target)
      print("Successfully disabled extra: '" .. input .. "'.")
    else
      print("Extra '" .. input .. "' is not currently enabled.")
    end
  else
    print("Error: Invalid action '" .. action .. "'.")
  end
end

local function extras_enable(args)
  handle_extras("enable", args)
end

local function extras_disable(args)
  handle_extras("disable", args)
end

vim.api.nvim_create_user_command("ExtrasEnable", extras_enable, {
  nargs = 1,
  complete = function()
    local keys = vim.tbl_keys(extras)
    table.sort(keys)
    return keys
  end,
})

vim.api.nvim_create_user_command("ExtrasDisable", extras_disable, {
  nargs = 1,
  complete = function()
    local keys = vim.tbl_keys(extras)
    table.sort(keys)
    return keys
  end,
})
