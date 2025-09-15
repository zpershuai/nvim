# Neovim 配置文档

## 插件管理

### 插件更新命令

**重要修正**：使用以下命令更新插件，而不是 `:NvimTreeOpen`：

```vim
" 同步插件（安装缺失的插件）
:Lazy sync

" 更新所有插件到最新版本
:Lazy update

" 清理未使用的插件
:Lazy clean
```

### 插件管理结构

当前配置使用集中的插件管理方式，所有插件定义在 `lua/user/plugins.lua` 中。

**推荐做法**：未来可以将插件按功能模块拆分到 `lua/user/plugins/` 目录：

```
lua/user/plugins/
├── init.lua          -- 主入口文件
├── ui.lua            -- 界面相关插件
├── lsp.lua           -- LSP 相关插件
├── git.lua           -- Git 相关插件
├── telescope.lua     -- 搜索相关插件
├── treesitter.lua    -- 语法高亮插件
└── colorschemes.lua  -- 主题插件
```

每个模块文件返回一个插件配置表，在主 `init.lua` 中合并：

```lua
-- lua/user/plugins/init.lua
local plugins = {}

-- 合并所有插件配置
for _, plugin_file in ipairs({
  "ui",
  "lsp", 
  "git",
  "telescope",
  "treesitter",
  "colorschemes"
}) do
  local ok, plugin_config = pcall(require, "user.plugins." .. plugin_file)
  if ok then
    vim.list_extend(plugins, plugin_config)
  end
end

return plugins
```

## LSP 配置

### 如何新增 LSP 配置

1. **安装语言服务器**
   ```vim
   :Mason
   ```
   在 Mason 界面中找到并安装对应语言的 server（如 `pyright`、`gopls` 等）

2. **创建配置文件**
   在 `lua/user/lsp/settings/` 目录下新建配置文件，例如 `python.lua`：
   ```lua
   -- lua/user/lsp/settings/python.lua
   return {
     settings = {
       python = {
         analysis = {
           typeCheckingMode = "basic",
           autoSearchPaths = true,
           useLibraryCodeForTypes = true,
         },
       },
     },
   }
   ```

3. **注册配置**
   在 `lua/user/lsp/configs.lua` 中的 `servers` 列表添加新的服务器：
   ```lua
   local servers = { 
     "jsonls", 
     "rust_analyzer", 
     "tsserver", 
     "eslint", 
     "html",
     "pyright"  -- 新增
   }
   ```

### 常用 LSP 命令

```vim
" 查看 LSP 信息
:LspInfo

" 重启 LSP 服务器
:LspRestart

" 查看诊断信息
:lua vim.diagnostic.open_float()
```

## 快捷键规范

### Leader Key

- **Leader Key**: `<Space>` (空格键)
- **Local Leader**: `<Space>` (空格键)

### 快捷键命名约定

- `<leader>f*` → 文件/搜索相关
  - `<leader>ff` - 查找文件
  - `<leader>fg` - 实时搜索
  - `<leader>fb` - 查找缓冲区

- `<leader>g*` → Git 操作
  - `<leader>gg` - Git 状态
  - `<leader>gd` - Git 差异
  - `<leader>gb` - Git 分支

- `<leader>l*` → LSP 功能
  - `<leader>lf` - 格式化代码
  - `<leader>li` - LSP 信息
  - `<leader>lj` - 下一个诊断
  - `<leader>lk` - 上一个诊断

- `<leader>t*` → 终端/工具
  - `<leader>tt` - 切换终端
  - `<leader>tf` - 浮动终端

- `<leader>w*` → 窗口操作
  - `<leader>ww` - 切换窗口
  - `<leader>wv` - 垂直分割
  - `<leader>ws` - 水平分割

## 测试与诊断

### 性能测试

```vim
" 启动时间分析（需要安装 vim-startuptime 插件）
:StartupTime

" 查看启动时间详情
:StartupTime --help
```

### 健康检查

```vim
" 检查 Neovim 整体健康状态
:checkhealth

" 检查 Lazy 插件管理器状态
:checkhealth lazy

" 检查 Mason 状态
:checkhealth mason

" 检查 LSP 状态
:checkhealth lsp
```

### 常用诊断命令

```vim
" 打开 Mason 管理界面
:Mason

" 查看已安装的 LSP 服务器
:Mason

" 检查 Treesitter 状态
:TSInstallInfo

" 查看插件状态
:Lazy
```

## 开发与提交规范

### 代码格式化

所有 Lua 文件使用 `stylua` 进行格式化：

```bash
# 安装 stylua
cargo install stylua

# 格式化单个文件
stylua lua/user/plugins.lua

# 格式化整个 lua 目录
stylua lua/
```

### Git 提交规范

遵循 [Conventional Commits](https://www.conventionalcommits.org/) 规范：

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**类型 (type)**：
- `feat`: 新功能
- `fix`: 修复 bug
- `docs`: 文档更新
- `style`: 代码格式调整（不影响功能）
- `refactor`: 代码重构
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动
- `config`: 配置文件修改

**示例**：
```
feat(lsp): 添加 Python LSP 支持

- 新增 pyright 语言服务器配置
- 添加 Python 特定设置
- 更新 Mason 自动安装列表

fix(keymaps): 修正格式化快捷键冲突

chore: 更新插件版本到最新
```

### 开发工作流

1. **创建功能分支**
   ```bash
   git checkout -b feat/new-lsp-support
   ```

2. **进行开发**
   - 修改配置文件
   - 测试功能
   - 格式化代码

3. **提交更改**
   ```bash
   git add .
   git commit -m "feat(lsp): 添加新语言支持"
   ```

4. **推送并创建 PR**
   ```bash
   git push origin feat/new-lsp-support
   ```

## 故障排除

### 常见问题

1. **插件安装失败**
   ```vim
   :Lazy clean
   :Lazy sync
   ```

2. **LSP 不工作**
   ```vim
   :LspRestart
   :checkhealth lsp
   ```

3. **Treesitter 高亮异常**
   ```vim
   :TSUpdate
   :TSInstallInfo
   ```

4. **性能问题**
   ```vim
   :StartupTime
   :checkhealth
   ```

### 重置配置

如果配置出现严重问题，可以重置到初始状态：

```bash
# 备份当前配置
mv ~/.config/nvim ~/.config/nvim.backup

# 重新克隆配置
git clone <your-repo> ~/.config/nvim

# 启动 Neovim 并等待插件安装
nvim
```
