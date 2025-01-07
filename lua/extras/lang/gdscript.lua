-- https://www.reddit.com/r/neovim/comments/1c2bhcs/godotgdscript_in_neovim_with_lsp_and_debugging_in/
-- https://github.com/Scony/godot-gdscript-toolkit

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "gdscript" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "gdtoolkit" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {
          name = "godot",
          cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
        },
      },
    },
  },
}
