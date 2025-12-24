local M = {}

---Format current buffer with conform.nvim
function M.format()
  local ok, conform = pcall(require, "conform")
  if ok then
    conform.format({ async = false, lsp_fallback = true })
  else
    vim.notify("conform.nvim not available", vim.log.levels.WARN)
  end
end

---Create user command for format
vim.api.nvim_create_user_command("Format", M.format, {
  desc = "Format buffer with conform.nvim",
})

return M
