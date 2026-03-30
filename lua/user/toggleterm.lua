local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true, buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

local toggleterm_group = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	group = toggleterm_group,
	pattern = "term://*",
	callback = function()
		set_terminal_keymaps()
	end,
})

local Terminal = require("toggleterm.terminal").Terminal

-- Configuration: Set to false to suppress warnings for missing tools
local SHOW_MISSING_TOOL_WARNINGS = true

-- Helper function to create terminal with executable check
local function create_safe_terminal(cmd, name)
	if vim.fn.executable(cmd) ~= 1 then
		if SHOW_MISSING_TOOL_WARNINGS then
			vim.notify(
				string.format("⚠️  %s is not installed or not in PATH.\nSkipping %s terminal setup.", cmd, name),
				vim.log.levels.WARN
			)
		end
		return nil
	end
	return Terminal:new({ cmd = cmd, hidden = true })
end

-- Safely create terminal instances with executable checks
-- Comment out tools you don't need to avoid warnings
local lazygit = create_safe_terminal("lazygit", "LazyGit")
local node = create_safe_terminal("node", "Node")
-- local ncdu = create_safe_terminal("ncdu", "NCDU")  -- Uncomment if you install ncdu
local htop = create_safe_terminal("htop", "Htop")
-- local python = create_safe_terminal("python", "Python")  -- Uncomment if you install python

function _LAZYGIT_TOGGLE()
	if lazygit then
		lazygit:toggle()
	else
		vim.notify("LazyGit is not available. Install it first: https://github.com/jesseduffield/lazygit", vim.log.levels.ERROR)
	end
end

function _NODE_TOGGLE()
	if node then
		node:toggle()
	else
		vim.notify("Node.js is not available. Install it from: https://nodejs.org/", vim.log.levels.ERROR)
	end
end

-- Uncomment if you install ncdu
-- function _NCDU_TOGGLE()
-- 	if ncdu then
-- 		ncdu:toggle()
-- 	else
-- 		vim.notify("NCDU is not available. Install it with your package manager.", vim.log.levels.ERROR)
-- 	end
-- end

function _HTOP_TOGGLE()
	if htop then
		htop:toggle()
	else
		vim.notify("Htop is not available. Install it with your package manager.", vim.log.levels.ERROR)
	end
end

-- Uncomment if you install python
-- function _PYTHON_TOGGLE()
-- 	if python then
-- 		python:toggle()
-- 	else
-- 		vim.notify("Python is not available. Install it from: https://www.python.org/", vim.log.levels.ERROR)
-- 	end
-- end
