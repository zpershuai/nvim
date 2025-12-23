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

-- Configure servers using new vim.lsp.config API
vim.lsp.config("eslint", merge_settings("eslint"))
vim.lsp.config("html", merge_settings("html"))
vim.lsp.config("jsonls", merge_settings("jsonls"))

-- Configure ts_ls (TypeScript/JavaScript)
vim.lsp.config("ts_ls", {
    on_attach = function(client, bufnr)
        -- Disable ts_ls formatting since we use conform/prettier
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        -- Call the default on_attach handler
        require("user.lsp.handlers").on_attach(client, bufnr)
    end,
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
    root_dir = require("lspconfig.util").root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "git"),
    on_attach = function(client, _)
        -- Disable formatting with lua_ls because using stylua
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
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
    root_dir = require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
})
