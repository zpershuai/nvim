return {
	-- Oil file explorer
	{
		"stevearc/oil.nvim",
		keys = {
			{ "<leader>eo", "<cmd>Oil<cr>", mode = "n", silent = true, desc = "Oil Explorer" },
		},
		config = function()
			require("oil").setup({
				columns = { "icon", "permissions", "size", "mtime" },
				buffer_options = {
					buflisted = false,
					bufhidden = "hide",
				},
				win_options = {
					wrap = false,
					signcolumn = "no",
					cursorcolumn = false,
					foldcolumn = "0",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
				},
				restore_win_options = true,
				skip_confirm_for_simple_edits = false,
				prompt_save_on_select_new_entry = true,
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-s>"] = "actions.select_vsplit",
					["<C-h>"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
					["g\\"] = "actions.toggle_trash",
				},
				use_default_keymaps = true,
				view_options = {
					show_hidden = false,
					is_hidden_file = function(name, bufnr)
						return vim.startswith(name, ".")
					end,
					is_always_hidden = function(name, bufnr)
						return false
					end,
				},
				git = {
					add = function(path)
						return vim.system({ "git", "add", path }, { text = true }):wait().code == 0
					end,
					mv = function(src_path, dest_path)
						return vim.system({ "git", "mv", src_path, dest_path }, { text = true }):wait().code == 0
					end,
					rm = function(path)
						return vim.system({ "git", "rm", path }, { text = true }):wait().code == 0
					end,
				},
				preview = {
					max_width = 0.9,
					min_width = { 40, 0.4 },
					width = nil,
					max_height = 0.9,
					min_height = { 5, 0.1 },
					height = nil,
					border = "rounded",
					win_options = {},
					update_on_cursor_moved = true,
				},
				progress = {
					max_width = 0.9,
					min_width = { 40, 0.4 },
					width = nil,
					max_height = { 10, 0.9 },
					min_height = { 5, 0.1 },
					height = nil,
					border = "rounded",
					minimized_border = "none",
					win_options = {},
				},
				ssh = {
					border = "rounded",
				},
				experimental_watch_for_changes = false,
			})
		end,
	},

	-- Project management
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				detection_methods = { "lsp", "pattern" },
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml", ".project" },
				ignore_lsp = {},
				exclude_dirs = {},
				show_hidden = false,
				silent_chdir = true,
				scope_chdir = "global",
				datapath = vim.fn.stdpath("data"),
			})

			local tele_status_ok, telescope = pcall(require, "telescope")
			if tele_status_ok then
				telescope.load_extension("projects")
			end
		end,
	},
}
