-- https://github.com/catppuccin/nvim
-- https://github.com/catppuccin/nvim?tab=readme-ov-file#integrations

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
    default_integrations = false,
    integrations = {
      aerial = true,
      blink_cmp = true,
      flash = true,
      fzf = true,
      grug_far = true,
      mason = true,
      mini = {
        enabled = true,
        indentscope_color = "text",
      },
      native_lsp = {
        enabled = true,
        virtual_text = {},
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
        inlay_hints = {},
      },
      semantic_tokens = true,
      snacks = true,
      treesitter = true,
      treesitter_context = true,
      rainbow_delimiters = true,
      which_key = true,
    },
  },
}
