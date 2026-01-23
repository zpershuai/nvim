# Health Check 快捷键使用指南

## 📦 安装说明

已自动添加到你的 Neovim 配置中：
- ✅ `lua/user/healthcheck.lua` - 新配置文件
- ✅ `init.lua` - 已添加自动加载

## 🎯 快捷键映射

### 方式 1: Which-key 菜单（推荐）

按 `<leader>h` 后会显示 Health 菜单：

```
<leader>h + h  → :checkhealth                  完整健康检查
<leader>h + l  → :checkhealth lsp              LSP 健康检查
<leader>h + t  → :checkhealth telescope        Telescope 健康检查
<leader>h + m  → :checkhealth mason            Mason 健康检查
<leader>h + c  → :checkhealth nvim-cmp         补全健康检查
<leader>h + g  → :checkhealth treesitter       Treesitter 健康检查
<leader>h + v  → :checkhealth vim.lsp          Vim LSP 健康检查
<leader>h + s  → :checkhealth vim.treesitter   Vim Treesitter 健康检查
```

**示例**：
- 按 `<Space>hh` → 运行完整健康检查
- 按 `<Space>hl` → 只检查 LSP 相关

### 方式 2: 备用快捷键

如果 `<leader>h` 已被其他插件占用：

```
<leader>C + h  → :checkhealth  健康检查
```

### 方式 3: 自定义命令

```vim
:Health      " 等同于 :checkhealth
:HealthLsp   " 等同于 :checkhealth lsp
```

## 🚀 立即使用

### 第一步：重启 Neovim

```bash
# 退出并重新打开
:qa
nvim
```

### 第二步：测试快捷键

```vim
" 方法 1: 使用 Which-key（会显示菜单）
<Space>h     " 等待查看菜单，然后按 h

" 方法 2: 直接按完整快捷键
<Space>hh    " 运行完整健康检查

" 方法 3: 使用命令
:Health
```

## 📊 常用健康检查

### 诊断配置问题

```vim
<Space>hh    " 查看所有问题的总览
```

### 检查 LSP 配置

```vim
<Space>hl    " 检查 LSP 是否正常工作
```

### 检查插件管理器

```vim
<Space>hm    " 检查 Mason 安装的工具
```

## 🔧 自定义配置

如果你想修改快捷键，编辑 `lua/user/healthcheck.lua`：

```lua
-- 示例：更改前缀从 <leader>h 到 <leader>d
wk.register({
  ["<leader>d"] = {  -- 改这里
    name = "󰓙 Diagnostics",
    h = { "<cmd>checkhealth<cr>", "Full Health Check" },
    -- ...
  },
})
```

## ⚠️ 故障排除

### 问题 1: 快捷键不工作

**检查步骤**：
```vim
" 1. 确认 which-key 已加载
:lua print(vim.inspect(require("which-key")))

" 2. 查看当前映射
:map <leader>h

" 3. 手动运行命令测试
:Health
```

### 问题 2: <leader>h 已被占用

**解决方案**：
使用备用快捷键 `<leader>Ch` 或编辑 `lua/user/healthcheck.lua` 更改前缀。

### 问题 3: Which-key 菜单不显示

**检查**：
```vim
:WhichKey <leader>
```

如果不显示，which-key 可能未正确加载。使用命令 `:Health` 作为替代。

## 💡 使用建议

### 日常使用

```vim
" 每天或遇到问题时运行
<Space>hh   " 快速全面检查

" 特定问题排查
<Space>hl   " LSP 不工作？
<Space>ht   " Telescope 有问题？
<Space>hm   " 工具缺失？
```

### 插件安装后

```vim
" 安装新插件后验证
:Lazy sync
<Space>hh   " 检查新插件健康状况
```

### 定期维护

```vim
" 每周运行一次
<Space>hh   " 发现潜在问题
```

## 📝 相关命令

```vim
:checkhealth                    完整检查
:checkhealth provider           检查 Python/Node 提供者
:checkhealth nvim               检查 Neovim 核心功能
:checkhealth vim.lsp            检查内置 LSP
:help checkhealth               查看帮助文档
```

## 🎨 图标说明

Health 菜单使用的图标：`󰓙` (医疗十字)

如果你的终端不支持 Nerd Font，可以修改 `lua/user/healthcheck.lua` 中的 `name` 字段：

```lua
name = "Health",  -- 移除图标
-- 或
name = "[H] Health",  -- 使用方括号
```

---

**提示**: 你的 `<leader>` 键默认是 `<Space>`（空格键）

---

**最后更新**: 2026-01-23
