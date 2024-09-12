local types = {
  absolute = "absolute",
  relative = "relative",
  filename = "filename",
  cwd = "cwd",
}

local function set_register_and_print(path_type, content)
  vim.fn.setreg("+", content)
  print("Copied " .. path_type .. " path: " .. content)
end

local function get_project_root()
  local project_root = LazyVim.root.get({ normalize = true })
  if not project_root:match("/$") then
    project_root = project_root .. "/"
  end
  return project_root
end

vim.api.nvim_create_user_command("CopyPath", function(opts)
  local file_path = vim.fn.expand("%:p")
  local valid_types = table.concat(vim.tbl_values(types), ", ")

  if opts.args == types.absolute then
    set_register_and_print(types.absolute, file_path)
  elseif opts.args == types.relative then
    local project_root = get_project_root()
    local relative_path = string.sub(file_path, #project_root + 1)
    set_register_and_print(types.relative, relative_path)
  elseif opts.args == types.filename then
    local file_name = vim.fn.expand("%:t")
    set_register_and_print(types.filename, file_name)
  elseif opts.args == types.cwd then
    local cwd = LazyVim.root.cwd()
    set_register_and_print(types.cwd, cwd)
  else
    print("Invalid argument. Use one of: " .. valid_types)
  end
end, {
  nargs = 1,
  complete = function(_, _, _)
    return vim.tbl_values(types)
  end,
})
