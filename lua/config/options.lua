-- This file is automatically loaded by plugins.core

-- Leader keys
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Symbols for displaying invisible characters
vim.opt.listchars = {
  trail = "·",
  nbsp = "␣",
}

-- Vim navigation for fzf results
vim.env.FZF_DEFAULT_OPTS = "--bind=ctrl-j:down,ctrl-k:up"

-- Enable spellchecking
vim.opt.spell = true
-- Avoid spell checking in generic buffers
vim.opt.spelloptions:append("noplainbuffer")

-- Concealed text is displayed normally. No hiding occurs.
vim.opt.conceallevel = 0

-- Enable the default ruler
vim.opt.ruler = true

-- LazyVim auto format
vim.g.autoformat = true

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
vim.g.snacks_animate = false

-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
vim.g.lazyvim_picker = "fzf"

-- LazyVim completion engine to use.
-- Can be one of: nvim-cmp, blink.cmp
-- Leave it to "auto" to automatically use the completion engine
-- enabled with `:LazyExtras`
vim.g.lazyvim_cmp = "nvim-cmp"
