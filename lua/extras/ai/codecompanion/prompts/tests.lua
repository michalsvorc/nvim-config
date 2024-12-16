--[[
Copyright (c) 2024 Oli Morris

Source: https://github.com/olimorris/codecompanion.nvim/blob/v10.7.0/lua/codecompanion/config.lua#L506
Changed:
  - system prompt content
--]]

local fmt = string.format
local constants = require("extras.ai.codecompanion.constants")

return {
  strategy = "chat",
  description = "Generate unit tests for the selected code",
  opts = {
    index = 6,
    is_default = true,
    is_slash_cmd = false,
    modes = { "v" },
    short_name = "tests",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = constants.SYSTEM_ROLE,
      content = [[
When generating unit tests, follow these steps:

1. Identify the programming language.
2. Identify the purpose of the function or module to be tested.
3. List the edge cases and typical use cases that should be covered in the tests and share the plan with the user.
4. Generate unit tests using an appropriate testing framework for the identified programming language.
  4.1. When the identified langauge is TypeScript, use Jest framework with TypeScript typing system.
5. Ensure the tests cover:
      - Normal cases
      - Edge cases
      - Error handling (if applicable)
6. Add an empty line to separate the declare, act, and assert phases in the test.
7. Provide the generated unit tests in a clear and organized manner without additional explanations or chat.
8. Don't add comments to the generated code.
]],
      opts = {
        visible = false,
      },
    },
    {
      role = constants.USER_ROLE,
      content = function(context)
        local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

        return fmt(
          [[
Please generate unit tests for this code from buffer %d:

```%s
%s
```
]],
          context.bufnr,
          context.filetype,
          code
        )
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}
