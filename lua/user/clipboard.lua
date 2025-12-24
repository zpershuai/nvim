-- Clipboard configuration for local and remote environments
-- Supports both local system clipboard and SSH/tmux OSC52 fallback

local M = {}

local function notify(message, level)
  if vim.g.user_clipboard_notify == true then
    vim.notify(message, level)
  end
end

-- Environment detection
local function is_ssh()
  return (os.getenv("SSH_CONNECTION") or os.getenv("SSH_TTY")) ~= nil
end

local function is_tmux()
  return os.getenv("TMUX") ~= nil
end

local function has_clipboard()
  return vim.fn.has("clipboard") == 1
end

-- Setup local clipboard (unnamedplus)
function M.setup_local()
  if has_clipboard() then
    vim.o.clipboard = "unnamedplus"
    notify("Local clipboard enabled (unnamedplus)", vim.log.levels.INFO)
  else
    notify("System clipboard not available", vim.log.levels.WARN)
  end
end

-- Setup OSC52 for SSH/tmux environments
function M.setup_osc52()
  local ok, osc52 = pcall(require, "osc52")
  if not ok then
    notify("OSC52 plugin not available", vim.log.levels.ERROR)
    return
  end

  osc52.setup({
    max_length = 0, -- Maximum length of selection (0 for no limit)
    silent = false, -- Disable message on successful copy
    trim = true, -- Trim surrounding whitespaces before copy
  })

  notify("OSC52 clipboard enabled for SSH/tmux", vim.log.levels.INFO)
end

-- Setup clipboard keybindings
function M.setup_keys()
  local is_remote = is_ssh() or is_tmux()
  
  if is_remote then
    -- Remote mode: use OSC52
    local ok, osc52 = pcall(require, "osc52")
    if ok then
      -- Normal mode: operator for copying
      vim.keymap.set("n", "<leader>Y", function()
        osc52.copy_operator()
      end, { desc = "Yank to system clipboard (OSC52)", silent = true })
      
      -- Normal mode: copy current line
      vim.keymap.set("n", "<leader>yY", function()
        osc52.copy(vim.fn.getline("."))
      end, { desc = "Yank line to system clipboard (OSC52)", silent = true })
      
      -- Visual mode: copy selection
      vim.keymap.set("v", "<leader>Y", function()
        osc52.copy_visual()
      end, { desc = "Yank selection to system clipboard (OSC52)", silent = true })
    end
  else
    -- Local mode: use system clipboard
    if has_clipboard() then
      -- Normal mode: operator for copying
      vim.keymap.set("n", "<leader>Y", function()
        vim.cmd('set operatorfunc=v:lua.require("user.clipboard")._copy_operator')
        return "g@"
      end, { desc = "Yank to system clipboard (local)", silent = true, expr = true })
      
      -- Normal mode: copy current line
      vim.keymap.set("n", "<leader>yY", '"+yy', { desc = "Yank line to system clipboard (local)", silent = true })
      
      -- Visual mode: copy selection
      vim.keymap.set("v", "<leader>Y", '"+y', { desc = "Yank selection to system clipboard (local)", silent = true })
    end
  end
end

-- Operator function for local clipboard
function M._copy_operator(type)
  local old_ve = vim.o.virtualedit
  vim.o.virtualedit = "all"
  vim.cmd('normal! `[v`]"+y')
  vim.o.virtualedit = old_ve
end

-- Initialize clipboard based on environment
function M.init()
  local is_remote = is_ssh() or is_tmux()
  
  if is_remote then
    -- SSH/tmux environment: use OSC52
    M.setup_osc52()
  else
    -- Local environment: use system clipboard
    M.setup_local()
  end
  
  -- Setup keybindings
  M.setup_keys()
  
  -- Log environment info
  local env_info = {
    ssh = is_ssh(),
    tmux = is_tmux(),
    clipboard = has_clipboard(),
    mode = is_remote and "OSC52" or "Local"
  }
  
  notify(
    string.format("Clipboard: %s (SSH:%s, TMUX:%s, CLIP:%s)", 
      env_info.mode, 
      env_info.ssh, 
      env_info.tmux, 
      env_info.clipboard
    ), 
    vim.log.levels.INFO
  )
end

return M
