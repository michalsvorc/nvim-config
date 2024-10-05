-- https://github.com/nvim-lua/plenary.nvim
-- All the lua functions I don't want to write twice.
--
-- This plugin acts as a dependency for numerous other plugins, primarily for visibility and version control purposes.
return {
  "nvim-lua/plenary.nvim",
  lazy = false,
  -- fixes the CodeCompanionChat buffer not switching back to modifiable input after server response
  commit = "f7adfc4b3f4f91aab6caebf42b3682945fbc35be",
}
