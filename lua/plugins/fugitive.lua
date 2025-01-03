-- https://github.com/tpope/vim-fugitive
-- Git wrapper and client.

local function toggleFugitive()
  local fugitive_bufnr = vim.g.fugitive_bufnr
  local fugitive_winid = vim.fn.bufwinid(fugitive_bufnr or -1)

  if fugitive_winid ~= -1 then
    vim.api.nvim_win_close(fugitive_winid, true)
    vim.g.fugitive_bufnr = nil
  else
    vim.cmd("vert Git")
    vim.g.fugitive_bufnr = vim.fn.bufnr("%")
  end
end

return {
  "tpope/vim-fugitive",
  event = "LazyFile",
  -- stylua: ignore
  keys = {
    { "<leader>ga", function() vim.cmd("Git commit --amend") end, desc = "Amend" },
    { "<leader>gB", function() vim.cmd("Git blame") end, desc = "Blame" },
    { "<leader>gc", function() vim.cmd("vert Git commit") end, desc = "Commit" },
    { "<leader>gd", function() vim.cmd("Gvdiffsplit") end, desc = "Diff" },
    { "<leader>gg", toggleFugitive, desc = "Git Client" },
    { "<leader>gl", function() vim.cmd("vert Git log") end, desc = "Log" },
    { "<leader>gp", function() vim.cmd("Git pull") end, desc = "Pull" },
    { "<leader>gP", function() vim.cmd("Git push") end, desc = "Push" },
    { "<leader>gR", function() vim.cmd("Gread") end, desc = "Read" },
    { "<leader>gss", function() vim.cmd("Git stash") end, desc = "Stash" },
    { "<leader>gsm", ':call feedkeys(":Git stash -m ", "n")<CR>', desc = "Stash with Message" },
    { "<leader>gw", function() vim.cmd("Gwrite") end, desc = "Write" },
    -- quick keys
    { "<leader>1", toggleFugitive, desc = "Git Client" },
  },
}
