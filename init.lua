-- disable loading LazyVim options
-- https://github.com/LazyVim/LazyVim/blob/v14.6.0/lua/lazyvim/config/init.lua#L21
package.loaded["lazyvim.config.options"] = true

-- set global paths
require("config.paths")

-- plugin options
require("config.plugins")

-- local options for overrides, not tracked by version control
pcall(require, "config._local")

-- bootstrap lazy.nvim
require("config.lazy")

-- load user commands
require(".commands")
