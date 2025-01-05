local M = {}

M.events = {
  menu_open = "BlinkCmpMenuOpen",
}

M.menu_hide = function()
  require("blink.cmp").hide()
end

return M
