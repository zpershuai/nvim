# LSP 配置完成总结

## ✅ 已完成的配置

### 1. LSP 语言服务器配置

**已配置的服务器**：

- `ts_ls` - TypeScript/JavaScript 支持（原 tsserver，已更新）
- `eslint` - ESLint 诊断和修复
- `html` - HTML 语言支持
- `jsonls` - JSON 语言支持

**配置文件位置**：

- `lua/user/lsp/configs.lua` - 主配置文件
- `lua/user/lsp/settings/ts_ls.lua` - TypeScript 特定设置
- `lua/user/lsp/settings/eslint.lua` - ESLint 特定设置
- `lua/user/lsp/settings/html.lua` - HTML 特定设置
- `lua/user/lsp/settings/jsonls.lua` - JSON 特定设置

**Mason 配置**：

```lua
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
```

**注意**：由于 `mason-lspconfig` 的自动安装功能存在兼容性问题，我们使用手动配置方式。您需要手动安装 LSP 服务器：

```vim
:Mason
```

### 2. 格式化配置 (conform.nvim)

**支持的文件类型**：

- `javascript`, `javascriptreact`
- `typescript`, `typescriptreact`
- `html`, `json`, `css`
- `scss`, `less`, `vue`, `svelte`

**格式化器优先级**：

1. 如果检测到 `.eslintrc.*` 文件：`eslint_d` → `prettierd` → `prettier`
2. 否则：`prettierd` → `prettier`

**ESLint 检测**：
自动检测以下配置文件：

- `.eslintrc`
- `.eslintrc.js`
- `.eslintrc.cjs`
- `.eslintrc.json`
- `.eslintrc.yaml`
- `.eslintrc.yml`
- `eslint.config.js`
- `eslint.config.cjs`
- `eslint.config.mjs`

### 3. Treesitter 解析器

**已安装的解析器**：

```lua
ensure_installed = {
    "cpp", "c", "lua", "make", "cmake", "markdown", "objc",
    "json", "typescript", "javascript", "html", "css",
    "scss", "vue", "svelte", "tsx"
}
```

### 4. 快捷键配置

**LSP 相关**：

- `<leader>lf` - 格式化代码（优先使用 conform，回退到 LSP）
- `<leader>li` - 显示 LSP 信息
- `<leader>lj` - 跳转到下一个诊断
- `<leader>lk` - 跳转到上一个诊断

**Telescope 搜索**：

- `<leader>ff` - 查找文件
- `<leader>fg` - 实时搜索
- `<leader>fb` - 查找缓冲区
- `<leader>fh` - 帮助标签
- `<leader>fr` - 最近文件
- `<leader>fc` - 命令

**Git 操作**：

- `<leader>gg` - 打开 Neogit
- `<leader>gd` - 打开差异视图
- `<leader>gs` - 暂存当前块
- `<leader>gu` - 取消暂存当前块
- `<leader>gp` - 预览当前块
- `<leader>gb` - 显示当前行 blame

**文件操作**：

- `<leader>e` - 切换文件树
- `<leader>E` - 在文件树中定位当前文件

**终端**：

- `<leader>tt` - 切换终端
- `<leader>tf` - 浮动终端
- `<leader>th` - 水平终端
- `<leader>tv` - 垂直终端

**窗口管理**：

- `<leader>wv` - 垂直分割
- `<leader>ws` - 水平分割
- `<leader>ww` - 切换窗口
- `<leader>wq` - 关闭窗口

**缓冲区管理**：

- `<leader>bd` - 删除缓冲区
- `<leader>bn` - 下一个缓冲区
- `<leader>bp` - 上一个缓冲区

## 🚀 使用方法

### 启动配置

1. 打开 Neovim：`nvim`
2. 等待插件自动安装（首次启动）
3. 使用 `:Lazy sync` 确保所有插件已安装

### 安装格式化工具

```bash
# 安装 Prettier
npm install -g prettier

# 安装 Prettierd（可选，更快的 Prettier）
npm install -g @fsouza/prettierd

# 安装 ESLint（如果需要）
npm install -g eslint

# 安装 eslint_d（可选，更快的 ESLint）
npm install -g eslint_d
```

### 验证配置

```vim
" 检查 LSP 状态
:LspInfo

" 检查 Mason 状态
:Mason

" 检查 Treesitter 状态
:TSInstallInfo

" 检查健康状态
:checkhealth
```

### 格式化代码

```vim
" 手动格式化当前文件
<leader>lf

" 或者使用命令
:ConformFormat
```

## 🔧 故障排除

### LSP 不工作

1. 检查服务器是否安装：`:Mason`
2. 重启 LSP：`:LspRestart`
3. 检查健康状态：`:checkhealth lsp`

### 格式化不工作

1. 检查格式化工具是否安装
2. 检查项目根目录是否有配置文件
3. 使用 `:ConformFormat` 手动格式化

### Treesitter 高亮异常

1. 更新解析器：`:TSUpdate`
2. 检查安装状态：`:TSInstallInfo`
3. 重新安装：`:TSInstall <language>`

## 📝 注意事项

1. **格式化优先级**：conform.nvim 优先于 LSP 格式化
2. **ESLint 集成**：自动检测项目中的 ESLint 配置
3. **性能优化**：使用 prettierd 和 eslint_d 获得更好的性能
4. **文件类型支持**：支持现代前端开发的所有主要文件类型

配置已完成，可以开始愉快的开发了！🎉
