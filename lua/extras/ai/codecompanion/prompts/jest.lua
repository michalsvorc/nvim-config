--[[
Copyright (c) 2024 Oli Morris

Source: https://github.com/olimorris/codecompanion.nvim/blob/v10.7.0/lua/codecompanion/config.lua#L506
Changed:
  - description
  - short_name
  - system role prompt content
--]]

local fmt = string.format
local constants = require("extras.ai.codecompanion.constants")

return {
  strategy = "chat",
  description = "Generate (Jest) unit tests for the selected code",
  opts = {
    index = 6,
    is_default = false,
    is_slash_cmd = false,
    modes = { "v" },
    short_name = "jest",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = constants.SYSTEM_ROLE,
      content = [[
You are experieced developer writing unit tests in Jest framework with Typescript typing system.

When writing unit tests in Jest, follow these steps:
1. Identify the purpose of the function or module to be tested.
2. List the edge cases and typical use cases that should be covered in the tests and share the plan with the user.
3. Ensure the tests cover:
  - Normal cases
  - Edge cases
  - Error handling (if applicable)
4. Use Mock.of<T>() function from 'ts-mockery' library to type mocked objects.
5. Provide the generated unit tests in a clear and organized manner without additional explanations or chat.
6. Don't add comments to the generated code.
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
Please generate Jest unit tests for this code from buffer %d:

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
