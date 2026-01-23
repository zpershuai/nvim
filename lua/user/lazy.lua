local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- Security notice: First-time installation
	vim.notify(
		"Lazy.nvim not found. Installing from GitHub...\n"
			.. "Source: https://github.com/folke/lazy.nvim.git\n"
			.. "Please ensure you are on a secure network connection.",
		vim.log.levels.WARN
	)

	local result = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})

	-- Verify installation success
	if vim.v.shell_error ~= 0 then
		vim.notify(
			"Failed to clone lazy.nvim:\n" .. result .. "\nPlease check your network connection and try again.",
			vim.log.levels.ERROR
		)
		return
	end

	vim.notify("Lazy.nvim installed successfully!", vim.log.levels.INFO)
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup("user.plugins", {
	defaults = { lazy = true },
	install = { colorscheme = { "tokyonight" } },
	checker = {
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
		check_pinned = false, -- check for pinned packages that can't be updated
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "habamax" },
	},
	-- Security: Display detailed change information during updates
	change_detection = {
		enabled = true,
		notify = true, -- Show notification when plugins change
	},
	ui = {
		-- a number <1 is a percentage., >1 is a fixed size
		size = { width = 0.8, height = 0.8 },
		wrap = true, -- wrap the lines in the ui
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "none",
		title = nil, ---@type string only works when border is not "none"
		title_pos = "center", ---@type "center" | "left" | "right"
		-- Show pills on top of the Lazy window
		pills = true, ---@type boolean
		icons = {
			cmd = " ",
			config = "",
			event = "",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "ó°² ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			require = "ó°¢± ",
			source = " ",
			start = "",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},
	concurrency = 5,
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	debug = false,
	change_detection = {
		notify = false,
	},
})

-- Security reminder: Display warning about reviewing plugin updates
vim.api.nvim_create_user_command("LazyUpdateSecure", function()
	vim.notify(
		"⚠️  Security Reminder:\n"
			.. "1. Review lazy-lock.json git diff after update\n"
			.. "2. Check changelogs for major version changes\n"
			.. "3. Be cautious with build hooks in new plugins\n"
			.. "\nProceed with :Lazy update",
		vim.log.levels.WARN
	)
	vim.cmd("Lazy update")
end, { desc = "Update plugins with security reminder" })
