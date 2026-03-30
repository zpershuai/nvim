local M = {}

local function with_rounded_border(handler)
	return function(err, result, ctx, config)
		config = vim.tbl_deep_extend("force", config or {}, { border = "rounded" })
		return handler(err, result, ctx, config)
	end
end

-- TODO: backfill this to template
M.setup = function()
	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
        signs = {
            text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
            },
        },
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = with_rounded_border(vim.lsp.handlers.hover)
	vim.lsp.handlers["textDocument/signatureHelp"] = with_rounded_border(vim.lsp.handlers.signature_help)
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
	-- end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-i>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev({ border = "rounded" })
	end, opts)
	vim.keymap.set("n", "gl", function()
		vim.diagnostic.open_float({ border = "rounded" })
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next({ border = "rounded" })
	end, opts)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
	vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", function()
		vim.lsp.buf.format({ bufnr = bufnr })
	end, { desc = "Format current buffer with attached LSP" })
end

M.on_attach = function(client, bufnr)
	-- vim.notify(client.name .. " starting...")
	-- TODO: refactor this into a method that checks if string in list
	if client.name == "tsserver" or client.name == "ts_ls" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
	M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
end

return M
