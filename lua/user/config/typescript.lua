local M = {}

function M.setup()
	require("typescript-tools").setup({
		on_attach = function(client, _)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
		end,
		settings = {
			separate_diagnostic_server = true,
			publish_diagnostic_on = "insert_leave",
			expose_as_code_action = {},
			tsserver_path = nil,
			tsserver_plugins = {},
			tsserver_max_memory = "auto",
			tsserver_format_options = {},
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
			tsserver_locale = "en",
			complete_function_calls = false,
			include_completions_with_insert_text = true,
			code_lens = "off",
			disable_member_code_lens = true,
			jsx_close_tag = {
				enable = false,
				filetypes = { "javascriptreact", "typescriptreact" },
			},
		},
	})
end

return M
