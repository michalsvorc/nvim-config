-- https://github.com/echasnovski/mini.surround
-- Neovim Lua plugin with fast and feature-rich surround actions.
return {
  "echasnovski/mini.surround",
  event = "LazyFile",
  version = false,
  opts = {
    -- prefixed with "g" to avoid conflicts with folke/flash.nvim
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
  },
  config = function(_, opts)
    require("mini.surround").setup(opts)
  end,
}
