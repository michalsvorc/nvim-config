return {
  small_window = {
    layout = "vertical",
    -- height is based on vim.o.lines, with a minimum of 25 lines
    height = math.max(math.floor(vim.o.lines * 0.5 + 0.5), 25),
    -- width is based on the number of columns, with a minimum of 80 columns
    width = math.max(math.floor(vim.o.columns * 0.5 + 0.5), 80),
    preview = {
      layout = "vertical",
      vertical = "down:45%",
    },
  },
}
