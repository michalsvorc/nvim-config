local M = {}

M.get_api_key = function(encrypted_file_path)
  local file = io.open(encrypted_file_path, "r")
  if not file then
    print("Error. File containing API key does not exist: " .. encrypted_file_path)
    return nil
  end
  file:close()

  local handler = io.popen("gpg --quiet --batch --yes --decrypt " .. encrypted_file_path)
  if not handler then
    print("Error. File containing API key could not be decrypted: " .. encrypted_file_path)
    return nil
  end
  local result = handler:read("*a")
  handler:close()
  return vim.trim(result)
end

return M
