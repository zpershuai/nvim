return {
	-- Notifications
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		keys = {
			{ "<leader>un", "<cmd>Telescope notify<cr>", mode = "n", silent = true, desc = "Notification History" },
			{ "<leader>ud", "<cmd>lua require('notify').dismiss()<cr>", mode = "n", silent = true, desc = "Dismiss Notifications" },
		},
		config = function()
			local notify = require("notify")
			notify.setup({
				background_colour = "#000000",
				fps = 30,
				icons = {
					DEBUG = "",
					ERROR = "",
					INFO = "",
					TRACE = "✎",
					WARN = "",
				},
				level = 2,
				minimum_width = 50,
				render = "default",
				stages = "fade_in_slide_out",
				timeout = 5000,
				top_down = true,
			})
			vim.notify = notify
		end,
	},

	-- Enhanced UI
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = false,
				},
			})
		end,
	},

	-- Enhanced UI for inputs and selects
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("dressing").setup({
				input = {
					enabled = true,
					default_prompt = "➤ ",
					win_options = {
						winblend = 0,
					},
				},
				select = {
					enabled = true,
					backend = { "telescope", "nui", "builtin" },
					telescope = require("telescope.themes").get_dropdown({
						winblend = 10,
						width = 0.8,
						previewer = false,
						prompt_title = false,
					}),
				},
			})
		end,
	},

	-- Colorizer
	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		keys = {
			{ "<leader>uc", "<cmd>ColorizerToggle<cr>", mode = "n", silent = true, desc = "Toggle Colorizer" },
		},
		config = function()
			require("colorizer").setup({
				filetypes = {
					"*",
					css = { css = true, css_fn = true },
					html = { css = true, css_fn = true },
					javascript = { css = true, css_fn = true },
					typescript = { css = true, css_fn = true },
					typescriptreact = { css = true, css_fn = true },
					javascriptreact = { css = true, css_fn = true },
				},
				user_default_options = {
					RGB = true,
					RRGGBB = true,
					names = true,
					RRGGBBAA = true,
					rgb_fn = true,
					hsl_fn = true,
					css = false,
					css_fn = false,
					mode = "background",
					tailwind = false,
					sass = { enable = false, parsers = { "css" } },
					virtualtext = "■",
					always_update = false,
				},
				buftypes = {},
			})
		end,
	},
}
