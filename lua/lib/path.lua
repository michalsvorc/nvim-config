local M = {}

--- Returns the current project root.
--- @return string The current project root.
M.get_project_root = function()
  return LazyVim.root.get({ normalize = true })
end

--- Returns the current working directory.
--- @return string The current working directory.
M.get_cwd = function()
  return LazyVim.root.cwd()
end

return M
