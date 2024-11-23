local fmt = string.format
return {
  strategy = "chat",
  description = "Generate a commit message (SR)",
  opts = {
    index = 10,
    is_default = true,
    is_slash_cmd = true,
    short_name = "commit_sr",
    auto_submit = true,
  },
  prompts = {
    {
      role = "user",
      content = function()
        return fmt(
          [[
          Follow these requirements when writing a commit message:
          1. It should start with the branch name.
            1.1 If the branch name is prefixed with a `feature/`, remove the prefix.
             Example: For branch `feature/ABC-123`, the commit message should start with ABC-123.
            1.2 If the branch name has no `feature/` prefix, use `[NO-TICKET]` instead of branch name
          2. After the branch name, add a colon and a space.
          3. The commit message should be in the descriptive, non-imperative mood.
          4. The commit message should end with a period.

          Given the git diff listed below, please generate a commit message for me:

```diff
The current branch is: %s
%s
```
]],
          vim.fn.system("git rev-parse --abbrev-ref HEAD"),
          vim.fn.system("git diff --no-ext-diff --staged")
        )
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}
