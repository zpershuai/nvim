return {
	-- Ufo folding engine with dependencies
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		event = "BufReadPost",
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					-- 检查是否有 LSP 客户端支持折叠
					local clients = vim.lsp.get_clients({ bufnr = bufnr })
					local has_lsp_fold = false
					for _, client in ipairs(clients) do
						if client.server_capabilities.foldingRangeProvider then
							has_lsp_fold = true
							break
						end
					end

					-- 如果有 LSP 折叠支持，优先使用 LSP，否则使用 treesitter
					if has_lsp_fold then
						return { "lsp", "treesitter" }
					else
						return { "treesitter", "indent" }
					end
				end,
				-- 确保标准折叠命令正常工作
				open_fold_hl_timeout = 400,
				close_fold_kinds_for_ft = {
					default = { "imports", "comment" },
					json = { "array" },
					c = { "comment", "region" },
					cpp = { "comment", "region" },
					python = { "imports", "comment" },
					lua = { "comment" },
					java = { "imports", "comment" },
					javascript = { "imports", "comment" },
					typescript = { "imports", "comment" },
					javascriptreact = { "imports", "comment" },
					typescriptreact = { "imports", "comment" },
				},
				preview = {
					win_config = {
						border = { "", "─", "", "", "", "─", "", "" },
						winhighlight = "Normal:Folded",
						winblend = 0,
					},
					mappings = {
						scrollU = "<C-u>",
						scrollD = "<C-d>",
						jumpTop = "[",
						jumpBot = "]",
					},
				},
				fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
					local newVirtText = {}
					local suffix = (" 󰁂 %d "):format(endLnum - lnum)
					local sufWidth = vim.fn.strdisplaywidth(suffix)
					local targetWidth = width - sufWidth
					local curWidth = 0
					for _, chunk in ipairs(virtText) do
						local chunkText = chunk[1]
						local chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if targetWidth > curWidth + chunkWidth then
							table.insert(newVirtText, chunk)
						else
							chunkText = truncate(chunkText, targetWidth - curWidth)
							local hlGroup = chunk[2]
							table.insert(newVirtText, { chunkText, hlGroup })
							chunkWidth = vim.fn.strdisplaywidth(chunkText)
							-- str width returned from truncate() may less than 2nd argument, need padding
							if curWidth + chunkWidth < targetWidth then
								suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
							end
							break
						end
						curWidth = curWidth + chunkWidth
					end
					table.insert(newVirtText, { suffix, "MoreMsg" })
					return newVirtText
				end,
			})

			-- Set default fold options
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			
			-- 确保标准折叠命令正常工作
			local ufo = require("ufo")
			vim.keymap.set("n", "zR", ufo.openAllFolds)
			vim.keymap.set("n", "zM", ufo.closeAllFolds)
			vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
			vim.keymap.set("n", "zm", ufo.closeFoldsWith)
			
			-- 标准折叠命令映射
			vim.keymap.set("n", "zo", function()
				local winid = ufo.peekFoldedLinesUnderCursor()
				if winid then
					ufo.openFoldsExceptKinds()
				else
					vim.cmd("normal! zo")
				end
			end, { desc = "Open fold" })
			
			vim.keymap.set("n", "zc", function()
				local winid = ufo.peekFoldedLinesUnderCursor()
				if winid then
					ufo.closeFoldsWith()
				else
					vim.cmd("normal! zc")
				end
			end, { desc = "Close fold" })
			
			vim.keymap.set("n", "za", function()
				local winid = ufo.peekFoldedLinesUnderCursor()
				if winid then
					ufo.closeFoldsWith()
				else
					vim.cmd("normal! za")
				end
			end, { desc = "Toggle fold" })
			
			vim.keymap.set("n", "zO", ufo.openAllFolds, { desc = "Open all folds recursively" })
			vim.keymap.set("n", "zC", ufo.closeAllFolds, { desc = "Close all folds recursively" })
			vim.keymap.set("n", "zA", function()
				local winid = ufo.peekFoldedLinesUnderCursor()
				if winid then
					ufo.closeAllFolds()
				else
					ufo.openAllFolds()
				end
			end, { desc = "Toggle all folds recursively" })
			
			vim.keymap.set("n", "K", function()
				local winid = ufo.peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end)
		end,
		keys = {
			{ "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", mode = "n", silent = true, desc = "Open all folds" },
			{ "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", mode = "n", silent = true, desc = "Close all folds" },
			{ "zr", "<cmd>lua require('ufo').openFoldsExceptKinds()<cr>", mode = "n", silent = true, desc = "Open folds except kinds" },
			{ "zm", "<cmd>lua require('ufo').closeFoldsWith()<cr>", mode = "n", silent = true, desc = "Close folds with" },
			{ "K", function() local winid = require('ufo').peekFoldedLinesUnderCursor() if not winid then vim.lsp.buf.hover() end end, mode = "n", silent = true, desc = "Peek fold or hover" },
		},
	},

	-- Pretty fold display - disabled due to compatibility issues
	--[[
	{
		"anuvyklack/pretty-fold.nvim",
		event = "BufReadPost",
		config = function()
			local ok, pretty_fold = pcall(require, "pretty-fold")
			if ok then
				pretty_fold.setup({
					keep_indentation = false,
					fill_char = "─",
					sections = {
						left = {
							"content",
						},
						right = {
							"number_of_folded_lines",
							": ",
							"percentage",
							" ──",
						},
					},
					ft_ignore = { "neogitstatus", "diff", "git", "gitcommit", "gitrebase", "NvimTree", "help" },
					use_manual = false,
				})
			else
				vim.notify("pretty-fold.nvim 加载失败，跳过配置", vim.log.levels.WARN)
			end
		end,
	},
	--]]

	-- Alternative fold preview - disabled due to pretty-fold compatibility issues
	--[[
	{
		"anuvyklack/fold-preview.nvim",
		dependencies = "anuvyklack/pretty-fold.nvim",
		event = "BufReadPost",
		config = function()
			local ok, preview = pcall(require, "fold-preview")
			if ok then
				preview.setup({
					border = "rounded",
					width = 60,
					height = 15,
				})
			end
		end,
		keys = {
			{ "<leader>fp", "<cmd>lua require('fold-preview').togglePreview()<cr>", mode = "n", silent = true, desc = "Preview fold" },
		},
	},
	--]]
}