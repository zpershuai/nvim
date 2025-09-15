-- TypeScript/JavaScript LSP settings
-- Formatting is handled by conform/prettier; disable ts_ls formatting
local M = {}

M.on_attach = function(client, bufnr)
  -- Disable ts_ls formatting since we use conform/prettier
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
end

M.settings = {
  typescript = {
    inlayHints = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
    suggest = {
      completeFunctionCalls = true,
      includeCompletionsForImportStatements = true,
      includeCompletionsWithSnippetText = true,
    },
    preferences = {
      includePackageJsonAutoImports = "auto",
      importModuleSpecifierPreference = "relative",
    },
  },
  javascript = {
    inlayHints = {
      includeInlayParameterNameHints = "none",
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
    },
    suggest = {
      completeFunctionCalls = true,
      includeCompletionsForImportStatements = true,
      includeCompletionsWithSnippetText = true,
    },
    preferences = {
      includePackageJsonAutoImports = "auto",
      importModuleSpecifierPreference = "relative",
    },
  },
}

return M