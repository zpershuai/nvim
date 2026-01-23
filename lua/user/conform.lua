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

-- Cache for git root directory to avoid repeated command execution
local git_root_cache = {}
local cache_invalidation_timer = nil

-- Clear cache after 5 seconds of inactivity
local function schedule_cache_clear()
  if cache_invalidation_timer then
    vim.fn.timer_stop(cache_invalidation_timer)
  end
  cache_invalidation_timer = vim.fn.timer_start(5000, function()
    git_root_cache = {}
  end)
end

-- Get git root with caching
local function get_git_root()
  local cwd = vim.fn.getcwd()

  -- Return cached value if available
  if git_root_cache[cwd] ~= nil then
    return git_root_cache[cwd]
  end

  -- Execute git command with timeout protection
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    -- Cache nil to avoid repeated failed attempts
    git_root_cache[cwd] = false
    schedule_cache_clear()
    return false
  end

  git_root = git_root:gsub("%s+", "")
  git_root_cache[cwd] = git_root
  schedule_cache_clear()
  return git_root
end

-- Check if .zpcode.format exists in git root (for project-specific format on save)
local function check_zpcode_format_flag()
  local git_root = get_git_root()
  if not git_root then
    return false
  end

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

