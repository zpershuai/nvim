-- LSP Configuration using Neovim 0.11+ vim.lsp.config API
-- Migration from nvim-lspconfig to native vim.lsp.config

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("user.config.mason_tools").setup()

local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok_mason_lspconfig then
    mason_lspconfig.setup({
        ensure_installed = {
            "clangd",
            "eslint",
            "html",
            "jsonls",
            "lua_ls",
            "ts_ls",
        },
    })
end

-- Helper function to merge custom settings from lua/user/lsp/settings/
local function merge_settings(server)
    local opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }
    local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
    end
    return opts
end

local function disable_formatting(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
end

local function get_ts_ls_client(bufnr)
    return vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })[1]
end

local function ts_source_action(bufnr, kind)
    vim.lsp.buf.code_action({
        bufnr = bufnr,
        apply = true,
        context = {
            only = { kind },
            diagnostics = vim.diagnostic.get(bufnr),
        },
    })
end

local function ts_organize_imports(bufnr)
    local client = get_ts_ls_client(bufnr)
    if not client then
        vim.notify("ts_ls is not attached to this buffer.", vim.log.levels.WARN)
        return
    end

    local response = client:request_sync("workspace/executeCommand", {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(bufnr) },
    }, 1000, bufnr)

    if response and response.err then
        vim.notify(response.err.message, vim.log.levels.ERROR)
    end
end

local function ts_rename_file(bufnr)
    local client = get_ts_ls_client(bufnr)
    if not client then
        vim.notify("ts_ls is not attached to this buffer.", vim.log.levels.WARN)
        return
    end

    local source = vim.api.nvim_buf_get_name(bufnr)
    local uv = vim.uv or vim.loop

    vim.ui.input({ prompt = "New path: ", default = source }, function(target)
        if not target or target == "" or target == source then
            return
        end

        if uv.fs_stat(target) then
            vim.notify("Cannot rename to an existing file.", vim.log.levels.ERROR)
            return
        end

        local response = client:request_sync("workspace/willRenameFiles", {
            files = {
                {
                    oldUri = vim.uri_from_fname(source),
                    newUri = vim.uri_from_fname(target),
                },
            },
        }, 1000, bufnr)

        if response and response.err then
            vim.notify(response.err.message, vim.log.levels.ERROR)
            return
        end

        local ok, rename_err = os.rename(source, target)
        if not ok then
            vim.notify(rename_err or "File rename failed.", vim.log.levels.ERROR)
            return
        end

        for _, open_bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(open_bufnr) and vim.api.nvim_buf_get_name(open_bufnr) == source then
                vim.api.nvim_buf_set_name(open_bufnr, target)
            end
        end

        if response and response.result then
            vim.lsp.util.apply_workspace_edit(response.result, client.offset_encoding)
        end
    end)
end

local function ts_on_attach(client, bufnr)
    disable_formatting(client)
    require("user.lsp.handlers").on_attach(client, bufnr)

    vim.keymap.set("n", "<leader>co", function()
        ts_organize_imports(bufnr)
    end, { buffer = bufnr, silent = true, desc = "Organize Imports" })

    vim.keymap.set("n", "<leader>cF", function()
        ts_source_action(bufnr, "source.fixAll")
    end, { buffer = bufnr, silent = true, desc = "Fix All" })

    vim.keymap.set("n", "<leader>cR", function()
        ts_rename_file(bufnr)
    end, { buffer = bufnr, silent = true, desc = "Rename File" })

    vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
        vim.lsp.buf.code_action({
            bufnr = bufnr,
            context = {
                only = { "source" },
                diagnostics = vim.diagnostic.get(bufnr),
            },
        })
    end, { desc = "TypeScript source actions" })
end

-- Configure servers using new vim.lsp.config API
vim.lsp.config("eslint", merge_settings("eslint"))
vim.lsp.config("html", merge_settings("html"))
vim.lsp.config("jsonls", merge_settings("jsonls"))

-- Configure ts_ls (TypeScript/JavaScript)
vim.lsp.config("ts_ls", {
    on_attach = ts_on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
    settings = {
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
    },
})

-- Configure lua_ls
vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
    on_attach = function(client, _)
        -- Disable formatting with lua_ls because using stylua
        disable_formatting(client)
    end,
    capabilities = require("user.lsp.handlers").capabilities,
    settings = {
        Lua = {
            format = {
                enable = false,
            },
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the vim global
                globals = { "vim", "P" },
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- Configure clangd (C/C++)
vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--query-driver=/usr/bin/clang*,/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
        "--clang-tidy",
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
        "--compile-commands-dir=../build/",
    },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
})

for _, server in ipairs({ "eslint", "html", "jsonls", "ts_ls", "lua_ls", "clangd" }) do
    vim.lsp.enable(server)
end
