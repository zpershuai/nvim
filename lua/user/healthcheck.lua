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
	wk.register({
		["<leader>h"] = {
			name = "󰓙 Health",
			h = { "<cmd>checkhealth<cr>", "Full Health Check" },
			l = { "<cmd>checkhealth lsp<cr>", "LSP Health" },
			t = { "<cmd>checkhealth telescope<cr>", "Telescope Health" },
			m = { "<cmd>checkhealth mason<cr>", "Mason Health" },
			c = { "<cmd>checkhealth nvim-cmp<cr>", "Completion Health" },
			g = { "<cmd>checkhealth treesitter<cr>", "Treesitter Health" },
			v = { "<cmd>checkhealth vim.lsp<cr>", "Vim LSP Health" },
			s = { "<cmd>checkhealth vim.treesitter<cr>", "Vim Treesitter Health" },
		},
	})

	-- Alternative: Single key mapping
	-- If <leader>h is already used, you can use a different prefix
	wk.register({
		["<leader>C"] = {
			name = "󰓙 Check",
			h = { "<cmd>checkhealth<cr>", "Health Check" },
		},
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
