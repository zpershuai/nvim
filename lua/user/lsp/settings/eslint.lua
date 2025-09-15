-- ESLint LSP for diagnostics and fixes
local M = {}

M.on_attach = function(client, bufnr)
  -- Disable eslint formatting since we use conform with eslint_d
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
end

M.settings = {
  -- Enable validation for these languages
  validate = "on",
  packageManager = nil, -- auto
  useESLintClass = false,
  format = false, -- formatting handled by conform with eslint_d/prettier
  codeActionOnSave = {
    enable = true,
    mode = "all",
  },
  experimental = {
    useFlatConfig = false,
  },
  workingDirectory = { mode = "auto" },
  -- File types to validate
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
  },
}

return M
