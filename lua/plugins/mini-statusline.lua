-- https://github.com/echasnovski/mini.statusline
-- Minimal and fast statusline module with opinionated default look.

return {
  "echasnovski/mini.statusline",
  dependencies = { "echasnovski/mini.icons" },
  event = "VeryLazy",
  config = function()
    local MiniStatusline = require("mini.statusline")

    -- https://github.com/echasnovski/mini.nvim/blob/v0.14.0/lua/mini/statusline.lua#L608
    local active_content = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 40 })
      local diff = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      })
    end
    require("mini.statusline").setup({ content = { active = active_content } })
  end,
}
