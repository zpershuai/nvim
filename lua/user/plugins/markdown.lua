return {
	-- Modern markdown rendering in Neovim
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "norg", "rmd", "org" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			enabled = false, -- Default disabled, enable manually
			max_file_size = 10.0, -- MB
			render_modes = { "n", "c", "i" },
			anti_conceal = { enabled = true },
			padding = { highlight = "Normal" },
			sign = { enabled = true },
			heading = {
				enabled = true,
				sign = true,
				position = "overlay",
				icons = { "", "", "", "", "", "" },
				signs = { "", "", "", "", "", "" },
				width = "full",
				left_margin = 0,
				left_pad = 0,
				right_pad = 0,
				min_width = 0,
				border = true,
				border_prefix = false,
				background = false,
				foreground = false,
				backgrounds = {
					"DiffAdd",
					"DiffChange",
					"DiffDelete",
				},
				foregrounds = {
					"@markup.heading.1.markdown",
					"@markup.heading.2.markdown",
					"@markup.heading.3.markdown",
					"@markup.heading.4.markdown",
					"@markup.heading.5.markdown",
					"@markup.heading.6.markdown",
				},
			},
			code = {
				enabled = true,
				sign = true,
				style = "full",
				position = "left",
				language_pad = 0,
				padding = { highlight = "Normal" },
				border = "thick",
				min_width = 60,
				left_margin = 0,
				left_pad = 0,
				right_pad = 0,
				disable_background = { "diff" },
				width = "full",
				border_virtual = true,
			},
			dash = {
				enabled = true,
				icon = "—",
				repeat_linebreak = false,
				width = "full",
				long_width = 60,
			},
			bullet = {
				enabled = true,
				icon = "•",
				icons = { "●", "○", "◆", "◇" },
				left_pad = 0,
				right_pad = 0,
				margin = 0,
				converted = true,
			},
			quote = {
				enabled = true,
				icon = "│",
				repeat_linebreak = false,
				margin = 0,
				left_pad = 0,
				right_pad = 0,
				highlight = "Special",
			},
			paragraph = {
				enabled = true,
				left_margin = 0,
				min_width = 60,
			},
			link = {
				enabled = true,
				image = "󰥶 ",
				email = "󰀓 ",
				hyperlink = "󰌹 ",
				highlight = "@markup.link.label.markdown_inline",
				custom = {
					web = { icon = "󰌹 ", pattern = "^https?://" },
				},
			},
			signature = {
				enabled = false,
			},
			inject = {
				enabled = true,
				heading = false,
			},
			win_options = {
				["conceallevel"] = {
					default = 0,
					rendered = 3,
				},
				["concealcursor"] = {
					default = "",
					rendered = "nvic",
				},
				["foldenable"] = {
					default = true,
					rendered = false,
				},
			},
			overrides = {
				preview = {
					enabled = true,
				},
			},
		},
		config = function(_, opts)
			local render_md = require("render-markdown")
			render_md.setup(opts)

			-- Create user command
			vim.api.nvim_create_user_command("MarkdownPreviewSplit", function()
				render_md.preview()
			end, {})

			-- Keymap for split preview (only in markdown files)
			vim.keymap.set("n", "<leader>um", function()
				local ft = vim.bo.filetype
				if ft == "markdown" or ft == "norg" or ft == "rmd" or ft == "org" then
					render_md.preview()
				else
					vim.notify("Not a markdown file", vim.log.levels.WARN)
				end
			end, {
				desc = "Markdown Preview Split (Left: Source, Right: Rendered)",
				silent = true,
			})
		end,
	},

	-- Browser-based markdown preview (optional, use when needed)
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{
				"<leader>mp",
				"<cmd>MarkdownPreviewToggle<CR>",
				mode = "n",
				silent = true,
				desc = "Toggle Markdown Preview (Browser)",
			},
		},
	},
}
