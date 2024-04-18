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

function check_git_root_for_file()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		return nil
	end
	git_root = git_root:gsub("%s+", "")

	-- 然后检查所需文件是否存在于 Git 根目录
	local format_file_path = git_root .. "/.zpcode.format"
	local f = io.open(format_file_path, "r")

	if f ~= nil then
		io.close(f)
		return git_root
	else
		return nil
	end
end

-- 创建一个 autocommand 组
vim.api.nvim_create_augroup("GitRootGroup", { clear = true })

-- format on save
-- 设置 BufEnter 自动命令
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "GitRootGroup",
	pattern = "*.js,*.rs,*.lua,*.md,*.MD,*.c,*.h,*.cpp,*.hpp,*.cc",
	callback = function()
		-- 检查仓库根目录是否存在所需文件
		local git_root = check_git_root_for_file()
		if git_root ~= nil then
			-- 如果文件存在，执行相关的autocmd命令
			-- 例如: 设置格式化快捷键
			-- 这里替换为你需要执行的具体操作
			vim.api.nvim_command("FormatWrite")
		end
	end,
})
