local M = {}

--- Get the API key from an encrypted file.
--- @param encrypted_file_path string The path to the encrypted file.
--- @return string | nil The API key or nil if the file does not exist or could not be decrypted.
M.get_api_key = function(encrypted_file_path)
  local file = io.open(encrypted_file_path, "r")
  if not file then
    vim.notify("File containing API key does not exist: " .. encrypted_file_path, vim.log.levels.ERROR)
    return nil
  end
  file:close()

  local handler = io.popen("gpg --quiet --batch --yes --decrypt " .. encrypted_file_path .. " 2>&1")
  if not handler then
    vim.notify("Could not execute gpg command.", vim.log.levels.ERROR)
    return nil
  end

  local output = handler:read("*all")
  local success, exit_reason, exit_code = handler:close()

  if success and not output:match("decryption failed") and not output:match("No secret key") then
    return vim.trim(output)
  else
    vim.notify(
      "File could not be decrypted: "
        .. encrypted_file_path
        .. ",Exit reason: "
        .. exit_reason
        .. ", Exit code: "
        .. exit_code,
      vim.log.levels.ERROR
    )
    return nil
  end
end

return M
