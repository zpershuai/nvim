local general_group = vim.api.nvim_create_augroup("_general_settings", { clear = true })
local git_group = vim.api.nvim_create_augroup("_git", { clear = true })
local markdown_group = vim.api.nvim_create_augroup("_markdown", { clear = true })
local auto_resize_group = vim.api.nvim_create_augroup("_auto_resize", { clear = true })
local alpha_group = vim.api.nvim_create_augroup("_alpha", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = general_group,
	pattern = { "qf", "help", "man", "lspinfo" },
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = args.buf, silent = true })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = general_group,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = general_group,
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = general_group,
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = git_group,
	pattern = "gitcommit",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = markdown_group,
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = auto_resize_group,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd("User", {
	group = alpha_group,
	pattern = "AlphaReady",
	callback = function(args)
		vim.opt.showtabline = 0
		vim.api.nvim_create_autocmd("BufUnload", {
			group = alpha_group,
			buffer = args.buf,
			once = true,
			callback = function()
				vim.opt.showtabline = 2
			end,
		})
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local last_line = vim.fn.line([['"]])
		if last_line > 1 and last_line <= vim.fn.line("$") then
			vim.api.nvim_exec2([[normal! g'"]], { output = false })
		end
	end,
})

-- Autoformat
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	callback = function()
-- 		vim.lsp.buf.format()
-- 	end,
-- })
