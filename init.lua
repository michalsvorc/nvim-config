-- Disable loading LazyVim options.
-- https://github.com/LazyVim/LazyVim/blob/v14.6.0/lua/lazyvim/config/init.lua#L21
package.loaded["lazyvim.config.options"] = true

-- Bootstrap lazy.nvim.
require(".lazy")

-- Load user commands.
require(".commands")
