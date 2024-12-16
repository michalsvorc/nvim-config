local fmt = string.format
local constants = require("extras.ai.codecompanion.constants")

return {
  strategy = "chat",
  description = "Refactor the selected code",
  opts = {
    index = 7,
    is_default = false,
    is_slash_cmd = false,
    modes = { "v" },
    short_name = "refactor",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = constants.SYSTEM_ROLE,
      content = [[
When asked to refactor code, follow these steps:

1. **Identify the Issues**: Carefully read the provided code and identify any potential issues or improvements.
2. **Plan the refactor**: Describe the plan for refactoring the code in pseudocode, detailing each step.
3. **Implement the refactor**: Write the corrected code in a single code block.
4. **Explain the refactor**: Briefly explain what changes were made and why.

Ensure the refactored code:

- Includes necessary imports.
- Handles potential errors.
- Follows best practices for readability and maintainability.
- Can be easily understood by other developers.
- Can be unit tested to ensure it works as expected.
- Is formatted correctly.

Use Markdown formatting and include the programming language name at the start of the code block.
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
Please refactor this code from buffer %d:

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
