return {
	-- Surround
	{
		"kylechui/nvim-surround",
		keys = {
			{ "<leader>sa", "ys", mode = "n", silent = true, desc = "Add surround (ys)", noremap = false },
			{ "<leader>sd", "ds", mode = "n", silent = true, desc = "Delete surround (ds)", noremap = false },
			{ "<leader>sr", "cs", mode = "n", silent = true, desc = "Replace surround (cs)", noremap = false },
		},
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					insert = "<C-g>s",
					insert_line = "<C-g>S",
					normal = "ys",
					normal_cur = "yss",
					normal_line = "yS",
					normal_cur_line = "ySS",
					visual = "S",
					visual_line = "gS",
					delete = "ds",
					change = "cs",
					change_line = "cS",
				},
			})
		end,
	},

	-- Flash navigation
	{
		"folke/flash.nvim",
		keys = {
			{ "<leader>fj", "<cmd>Flash<cr>", mode = "n", silent = true, desc = "Flash Jump" },
			{ "<leader>fJ", "<cmd>Flash Treesitter<cr>", mode = "n", silent = true, desc = "Flash Treesitter" },
		},
		config = function()
			require("flash").setup({
				modes = {
					char = {
						enabled = false,
					},
					treesitter = {
						enabled = true,
						disable = { "lazy", "fzf", "regex" },
						debounce = 15,
						multi_line = true,
						label = {
							before = true,
							after = true,
							style = "inline",
						},
						highlight = {
							backdrop = false,
							matches = false,
						},
						pattern = [[\b\w+]], -- ripgrep regex
						action = function(match, state)
							state:hide()
							vim.api.nvim_win_set_cursor(0, { match.row, match.col + 1 })
						end,
						label = {
							before = { 0, 0 },
							after = { 0, -1 },
							style = "inline",
						},
						keys = { "f", "F", "t", "T", ";", "," },
					},
				},
			})
		end,
	},

	-- Mini.ai and Mini.operators
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup({
				n_lines = 50,
				search_method = "cover_or_next",
				show_early_steps = true,
				silent = true,
				use_advice = true,
				custom_textobjects = {
					o = require("mini.ai").gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
					d = { "%f[%d]%d+" },
					q = { '^"(.-)"%s*$', "^'(.-)'%s*$", "`(.-)`%s*$" },
					b = { "%b()", "%b[]", "%b{}" },
					B = { "%b()", "%b[]", "%b{}", "%b<>" },
				},
			})
		end,
	},

	{
		"echasnovski/mini.operators",
		event = "VeryLazy",
		config = function()
			require("mini.operators").setup({
				replace = {
					prefix = "gr",
					func = function(visual_mode, register)
						local operator = require("mini.operators").make_operator(function(selection)
							local query = vim.fn.input("Replace with: ")
							if query ~= "" then
								selection:replace(query)
							end
						end)
						operator(visual_mode, register)
					end,
				},
				sort = {
					prefix = "gs",
					func = function(visual_mode, register)
						local operator = require("mini.operators").make_operator(function(selection)
							selection:sort()
						end)
						operator(visual_mode, register)
					end,
				},
				evaluate = {
					prefix = "g=",
					func = function(visual_mode, register)
						local operator = require("mini.operators").make_operator(function(selection)
							selection:evaluate()
						end)
						operator(visual_mode, register)
					end,
				},
				exchange = {
					prefix = "gx",
					func = function(visual_mode, register)
						local operator = require("mini.operators").make_operator(function(selection)
							selection:exchange()
						end)
						operator(visual_mode, register)
					end,
				},
			})
		end,
	},
}
