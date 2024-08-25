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
  config = function()
    require("mini.icons").setup()
  end,
}
