-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/v14.6.0/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Start terminal in insert mode.
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- Quickfix buffer keymaps
-- Dependencies: stevearc/quicker.nvim
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf", -- Trigger only for the quickfix filetype
  callback = function(event)
    vim.keymap.set("n", ">", function()
      require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
    end, {
      buffer = event.buf,
      silent = true,
      noremap = true,
      desc = "Expand Context",
    })
    vim.keymap.set("n", "<", function()
      require("quicker").collapse()
    end, {
      buffer = event.buf,
      silent = true,
      noremap = true,
      desc = "Collapse Context",
    })
    vim.keymap.set("n", "R", function()
      require("quicker").refresh()
    end, {
      buffer = event.buf,
      silent = true,
      noremap = true,
      desc = "Refresh List",
    })
  end,
})
