-- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
local prompts_path = "extras/ai/codecompanion/prompts/"
return {
  ["Refactor code"] = require(prompts_path .. "refactor"),
  ["Vue3"] = require(prompts_path .. "vue3"),
  ["Jest"] = require(prompts_path .. "jest"),
  -- Default prompts overrides
  ["Unit Tests"] = require(prompts_path .. "tests"),
  ["Generate a Commit Message (SR)"] = require(prompts_path .. "commit_sr"),
}
