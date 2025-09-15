local ok, conform = pcall(require, "conform")
if not ok then
  return
end

-- Detect eslint config presence
local function has_eslint(root)
  local candidates = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    "eslint.config.js",
    "eslint.config.cjs",
    "eslint.config.mjs",
  }
  for _, name in ipairs(candidates) do
    local file_path = (root or ".") .. "/" .. name
    local stat = vim.loop.fs_stat(file_path)
    if stat then
      return true
    end
  end
  return false
end

conform.setup({
  notify_on_error = true,
  format_on_save = false,
  formatters_by_ft = {
    javascript = function(bufnr)
      local root = require("conform.util").root_file({
        ".git",
        "package.json",
        ".eslintrc",
        "eslint.config.js",
      }, bufnr)
      if has_eslint(root) then
        return { "eslint_d", "prettierd", "prettier" }
      end
      return { "prettierd", "prettier" }
    end,
    javascriptreact = function(bufnr)
      local root = require("conform.util").root_file({
        ".git",
        "package.json",
        ".eslintrc",
        "eslint.config.js",
      }, bufnr)
      if has_eslint(root) then
        return { "eslint_d", "prettierd", "prettier" }
      end
      return { "prettierd", "prettier" }
    end,
    typescript = function(bufnr)
      local root = require("conform.util").root_file({
        ".git",
        "package.json",
        ".eslintrc",
        "eslint.config.js",
      }, bufnr)
      if has_eslint(root) then
        return { "eslint_d", "prettierd", "prettier" }
      end
      return { "prettierd", "prettier" }
    end,
    typescriptreact = function(bufnr)
      local root = require("conform.util").root_file({
        ".git",
        "package.json",
        ".eslintrc",
        "eslint.config.js",
      }, bufnr)
      if has_eslint(root) then
        return { "eslint_d", "prettierd", "prettier" }
      end
      return { "prettierd", "prettier" }
    end,
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    less = { "prettierd", "prettier" },
    vue = { "prettierd", "prettier" },
    svelte = { "prettierd", "prettier" },
  },
  formatters = {
    eslint_d = {
      command = "eslint_d",
      args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
      stdin = true,
      cwd = require("conform.util").root_file({ ".git", "package.json", ".eslintrc", "eslint.config.js" }),
      exit_codes = { 0, 1 }, -- eslint_d returns 1 when warnings are present
    },
  },
})

-- Optional: user command for convenience
vim.api.nvim_create_user_command("ConformFormat", function()
  conform.format({ async = false, lsp_fallback = true })
end, { desc = "Format with conform.nvim" })

