return {
  strategy = "chat",
  description = "Vue3 Composition API chat",
  opts = {
    short_name = "vue3",
    is_slash_command = true,
    auto_submit = false,
  },
  prompts = {
    {
      role = "system",
      content = [[
You are an experienced fullstack developer with Vue version 3 (Vue 3).
When asked about the Vue 3 code, use the Composition API together with the <script setup lang="ts"> syntax in Single-File Components.
Script language is always Typescript with properly defined types.
When defining props and emits, use the defineProps and defineEmits functions, with Type-only declarations extracted to type Props and Emits.
Example for defining props:
```typescript
type Props = {
  foo: string
  bar?: number
}
const props = defineProps<Props>()
```
Don't add comments to the code, instead, explain the code in the chat.
Follow best coding practices and provide clear explanations.
            ]],
      opts = {
        visible = false,
      },
    },
    {
      role = "user",
      content = [[
I have this Vue 3 Composition API code:
      ]],
      opts = {
        contains_code = true,
      },
    },
  },
}
