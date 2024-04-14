local status, formatter = pcall(require, "formatter")
if not status then
	vim.notify("没有找到 formatter")
	return
end

local function clang_format()
	return {
		exe = "clang-format",
		args = {
			"--style=file:$HOME/.config/nvim/lua/user/formatter/google-style.clang-format --assume-filename",
			vim.api.nvim_buf_get_name(0),
		},
		stdin = true,
		cwd = vim.fn.expand("%:p:h"),
	}
end

formatter.setup({
	filetype = {
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						-- "--config-path "
						--   .. os.getenv("XDG_CONFIG_HOME")
						--   .. "/stylua/stylua.toml",
						"-",
					},
					stdin = true,
				}
			end,
		},
		rust = {
			-- Rustfmt
			function()
				return {
					exe = "rustfmt",
					args = { "--emit=stdout" },
					stdin = true,
				}
			end,
		},
		javascript = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
					stdin = true,
				}
			end,
		},
		markdown = {
			function()
				return {
					exe = "prettier",
					args = { "--parser", "markdown" },
					stdin = true,
				}
			end,
		},
		c = { clang_format },
		cpp = { clang_format },
	},
})

-- format on save
vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.rs,*.lua,*.md,*.MD,*.c,*.h,*.cpp,*.hpp,*.cc FormatWrite
augroup END
]],
	true
)
