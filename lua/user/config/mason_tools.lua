local M = {}

function M.setup()
    local ok, mason_tool_installer = pcall(require, "mason-tool-installer")
    if not ok then
        return
    end

    mason_tool_installer.setup({
        ensure_installed = {
            "clang-format",
            "prettier",
            "rustfmt",
            "stylua",
            "tree-sitter-cli",
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 1000,
        debounce_hours = 24,
    })
end

return M
