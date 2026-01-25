-- Health Check Keybindings
-- Quick access to Neovim's checkhealth functionality

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Method 1: Simple direct mapping
-- Uncomment if you don't use which-key
-- keymap("n", "<leader>hc", "<cmd>checkhealth<cr>", vim.tbl_extend("force", opts, { desc = "Check Health" }))

-- Method 2: Which-key integration (recommended)
local ok, wk = pcall(require, "which-key")
if ok then
	wk.add({
		{ "<leader>h", group = "󰓙 Health" },
		{ "<leader>hh", "<cmd>checkhealth<cr>", desc = "Full Health Check" },
		{ "<leader>hl", "<cmd>checkhealth lsp<cr>", desc = "LSP Health" },
		{ "<leader>ht", "<cmd>checkhealth telescope<cr>", desc = "Telescope Health" },
		{ "<leader>hm", "<cmd>checkhealth mason<cr>", desc = "Mason Health" },
		{ "<leader>hc", "<cmd>checkhealth nvim-cmp<cr>", desc = "Completion Health" },
		{ "<leader>hg", "<cmd>checkhealth treesitter<cr>", desc = "Treesitter Health" },
		{ "<leader>hv", "<cmd>checkhealth vim.lsp<cr>", desc = "Vim LSP Health" },
		{ "<leader>hs", "<cmd>checkhealth vim.treesitter<cr>", desc = "Vim Treesitter Health" },
	})

	-- Alternative: Single key mapping
	-- If <leader>h is already used, you can use a different prefix
	wk.add({
		{ "<leader>C", group = "󰓙 Check" },
		{ "<leader>Ch", "<cmd>checkhealth<cr>", desc = "Health Check" },
	})
else
	-- Fallback if which-key is not available
	keymap("n", "<leader>hh", "<cmd>checkhealth<cr>", vim.tbl_extend("force", opts, { desc = "Full Health Check" }))
	keymap("n", "<leader>hl", "<cmd>checkhealth lsp<cr>", vim.tbl_extend("force", opts, { desc = "LSP Health" }))
	keymap("n", "<leader>ht", "<cmd>checkhealth telescope<cr>", vim.tbl_extend("force", opts, { desc = "Telescope Health" }))
	keymap("n", "<leader>hm", "<cmd>checkhealth mason<cr>", vim.tbl_extend("force", opts, { desc = "Mason Health" }))
end

-- User command for quick access
vim.api.nvim_create_user_command("Health", function()
	vim.cmd("checkhealth")
end, { desc = "Run :checkhealth" })

vim.api.nvim_create_user_command("HealthLsp", function()
	vim.cmd("checkhealth lsp")
end, { desc = "Run :checkhealth lsp" })
