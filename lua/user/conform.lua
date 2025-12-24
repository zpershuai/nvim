local ok, conform = pcall(require, "conform")
if not ok then
  return
end

conform.setup({
  notify_on_error = true,
  format_on_save = false,
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    markdown = { "prettier" },
    md = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    less = { "prettier" },
    vue = { "prettier" },
    svelte = { "prettier" },
  },
  formatters = {
    stylua = {
      prepend_args = { "--search-parent-directories" },
    },
    ["clang-format"] = {
      prepend_args = { "--style=Google" },
    },
  },
})

-- Check if .zpcode.format exists in git root (for project-specific format on save)
local function check_zpcode_format_flag()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    return false
  end
  git_root = git_root:gsub("%s+", "")

  local format_file = git_root .. "/.zpcode.format"
  local f = io.open(format_file, "r")
  if f ~= nil then
    io.close(f)
    return true
  end
  return false
end

-- Auto-format on save (only when .zpcode.format flag exists)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if check_zpcode_format_flag() then
      conform.format({ async = false, lsp_fallback = true })
    end
  end,
})

-- Optional: user command for convenience
vim.api.nvim_create_user_command("ConformFormat", function()
  conform.format({ async = false, lsp_fallback = true })
end, { desc = "Format with conform.nvim" })

