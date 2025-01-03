-- https://github.com/echasnovski/mini.icons
-- Icon provider.

return {
  "echasnovski/mini.icons",
  event = "VeryLazy",
  version = false,
  opts = {
    file = {
      [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
      ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
    },
    filetype = {
      dotenv = { glyph = "", hl = "MiniIconsYellow" },
    },
  },
  config = function(_, opts)
    local MiniIcons = require("mini.icons")
    MiniIcons.setup(opts)
    MiniIcons.mock_nvim_web_devicons()
  end,
}
