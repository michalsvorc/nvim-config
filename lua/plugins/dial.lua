-- https://github.com/monaqa/dial.nvim
-- Extended increment/decrement.

local function manipulate(action, mode)
  return function()
    require("dial.map").manipulate(action, mode)
  end
end

return {
  "monaqa/dial.nvim",
  event = "LazyFile",
  version = false,
  keys = {
    { "<C-a>", mode = "n", manipulate("increment", "normal"), desc = "Increment in normal mode" },
    { "<C-x>", mode = "n", manipulate("decrement", "normal"), desc = "Decrement in normal mode" },
    { "g<C-a>", mode = "n", manipulate("increment", "gnormal"), desc = "Increment in gnormal mode" },
    { "g<C-x>", mode = "n", manipulate("decrement", "gnormal"), desc = "Decrement in gnormal mode" },
    { "<C-a>", mode = "v", manipulate("increment", "visual"), desc = "Increment in visual mode" },
    { "<C-x>", mode = "v", manipulate("decrement", "visual"), desc = "Decrement in visual mode" },
    { "g<C-a>", mode = "v", manipulate("increment", "gvisual"), desc = "Increment in gvisual mode" },
    { "g<C-x>", mode = "v", manipulate("decrement", "gvisual"), desc = "Decrement in gvisual mode" },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.constant.alias.bool,
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.semver.alias.semver,
      },
    })
  end,
}
