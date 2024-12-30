require("lazyvim.config").init()

return {
  { "folke/lazy.nvim", version = "*" },
  {
    "LazyVim/LazyVim",
    priority = 10000,
    lazy = false,
    opts = {},
    cond = true,
    version = "*",
    config = function()
      require(".lazyvim").setup({
        colorscheme = "catppuccin",
        defaults = {
          autocmds = true,
          keymaps = false,
        },
        news = {
          lazyvim = false,
          neovim = false,
        },
      })
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
  },
}
