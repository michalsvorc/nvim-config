-- https://github.com/catppuccin/nvim

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    custom_highlights = function(colors)
      return {
        WinSeparator = { fg = colors.surface2 },
        LineNr = { fg = colors.overlay0 },
        CursorLineNr = { fg = colors.blue },
        Comment = { fg = colors.subtext0 },
      }
    end,
  },
}
