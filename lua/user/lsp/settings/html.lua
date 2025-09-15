-- HTML LSP settings
local M = {}

M.on_attach = function(client, bufnr)
  -- Disable html formatting since we use conform/prettier
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
end

M.filetypes = { "html", "templ", "eruby" }
M.init_options = {
  provideFormatter = false, -- external formatter via conform
}

M.settings = {
  html = {
    format = {
      enable = false, -- handled by conform
    },
    suggest = {
      html5 = true,
    },
    hover = {
      documentation = true,
      references = true,
    },
  },
}

return M

