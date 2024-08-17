local lua_version = "5.1"

vim.opt.runtimepath:append(
  vim.fs.joinpath(
    vim.fn.stdpath("data") --[[@as string]],
    "rocks",
    "lib",
    "luarocks",
    string.format("rocks-%s", lua_version),
    "tree-sitter-*",
    "*"
  )
)

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

local function build_command(language)
  return string.format(
    "luarocks --lua-version=%s --tree=%s/.local/share/nvim/rocks --dev install tree-sitter-%s",
    lua_version,
    os.getenv("HOME"),
    language
  )
end

local function notify_user(operation, success, output)
  local status = success and "OK" or "ERROR"
  print(string.format("%s: Installation of parser tree-sitter-%s", status, operation))
  if not success then
    print("Reason: " .. output)
  end
end

vim.api.nvim_create_user_command("TSInstall", function(opts)
  local cmd = build_command(opts.args)
  local output = vim.fn.system(cmd)
  notify_user(opts.args, vim.v.shell_error == 0, output)
end, { nargs = 1 })
