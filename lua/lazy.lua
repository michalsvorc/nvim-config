-- Bootstrap lazy.nvim.
-- https://lazy.folke.io/installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load config files.
-- set paths
require("config.paths")
-- plugin options
require("config.plugins")
-- local options for overrides, not tracked by version control
pcall(require, "config._local")

-- Setup lazy.nvim.
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim" },
    { import = "plugins" },
    { import = "plugins/_local" },
  },
  install = {},
  checker = { enabled = false },
  ui = {
    size = { width = 1, height = 1 },
    backdrop = 0,
  },
  defaults = {
    lazy = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
