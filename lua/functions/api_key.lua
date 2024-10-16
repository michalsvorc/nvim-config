local M = {}

M.get_api_key = function(encrypted_file_path)
  local file = io.open(encrypted_file_path, "r")
  if not file then
    print("Error. File containing API key does not exist: " .. encrypted_file_path)
    return nil
  end
  file:close()

  local handler = io.popen("gpg --quiet --batch --yes --decrypt " .. encrypted_file_path .. " 2>&1")
  if not handler then
    print("Error. Could not execute gpg command.")
    return nil
  end

  local output = handler:read("*all")
  local success, exit_reason, exit_code = handler:close()

  if success and not output:match("decryption failed") and not output:match("No secret key") then
    return vim.trim(output)
  else
    print("Error. File could not be decrypted: " .. encrypted_file_path)
    print("Exit reason: " .. exit_reason .. ", Exit code: " .. exit_code)
    return nil
  end
end

return M
