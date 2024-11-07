--[[ local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer") ]]
--[[ if not status_ok then ]]
--[[ 	return ]]
--[[ end ]]

local lspconfig = require("lspconfig")

local servers = { "jsonls", "rust_analyzer" }

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

--[[ lsp_installer.setup({ ]]
--[[ 	automatic_installation = true, ]]
--[[ }) ]]

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end
	lspconfig[server].setup(opts)
end

lspconfig.lua_ls.setup({
	-- disable formatting with `lua_ls` because using `stylua` in `null_ls`
	on_attach = function(client, _)
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
	end,

	root_dir = root_dir,
	capabilities = capabilities,
	settings = {
		Lua = {
			format = {
				enable = false,
			},
			runtime = {
				version = "LuaJIT",
				-- Setup your lua path
				-- path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "P" },
			},
			-- workspace = {
			--   -- Make the server aware of Neovim runtime files
			--   library = vim.api.nvim_get_runtime_file("", true),
			-- },
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.clangd.setup({
	cmd = {
		"clangd",
		"--background-index",
		"--query-driver=/usr/bin/clang*,/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
		"--clang-tidy",
		-- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
		-- to add more checks, create .clang-tidy file in the root directory
		-- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
		-- "--clang-tidy-checks=*",
		"--all-scopes-completion",
		"--cross-file-rename",
		"--completion-style=detailed",
		"--completion-parse=always",
		"--include-ineligible-results",
		"--function-arg-placeholders",
		"--header-insertion-decorators",
		"--header-insertion=iwyu",
		"--pch-storage=memory",
		"--limit-results=500",
		"--use-dirty-headers",
		--[[ "--malloc-trim", ]]
		"--compile-commands-dir=../build/",
		-- "-j=2",
	},
})
