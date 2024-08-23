-- https://github.com/MagicDuck/grug-far.nvim
-- Find And Replace plugin.
local buffer_extension = function()
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  return ext and ext ~= "" and "*." .. ext or nil
end

return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  opts = {
    headerMaxWidth = 80,
    transient = true,
    prefills = {
      filesFilter = buffer_extension(),
      flags = "-.",
    },
  },
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").grug_far()
      end,
      mode = { "n", "v" },
      desc = "Search+Replace",
    },
    {
      "<leader>sr",
      function()
        local opts = {
          prefills = {
            search = vim.fn.expand("<cword>"),
          },
        }
        require("grug-far").grug_far(opts)
      end,
      mode = "v",
      desc = "Search+Replace (selection)",
    },
    {
      "<leader>sR",
      function()
        local opts = {
          prefills = {
            flags = vim.fn.expand("%"),
          },
        }
        require("grug-far").grug_far(opts)
      end,
      mode = "n",
      desc = "Search+Replace (current buffer)",
    },
    {
      "<leader>sR",
      function()
        local opts = {
          prefills = {
            search = vim.fn.expand("<cword>"),
            flags = vim.fn.expand("%"),
          },
        }
        require("grug-far").grug_far(opts)
      end,
      mode = "v",
      desc = "Search+Replace (selection, current buffer)",
    },
  },
}
