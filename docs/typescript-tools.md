# typescript-tools.nvim - TypeScript 开发工具

typescript-tools.nvim 是一个强大的 TypeScript 开发工具，提供组织导入、修复所有问题、重命名文件等功能。

## 安装方式

```lua
{
  "pmizio/typescript-tools.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  keys = {
    { "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", mode = "n", silent = true, desc = "Organize Imports" },
    { "<leader>cF", "<cmd>TSToolsFixAll<cr>", mode = "n", silent = true, desc = "Fix All" },
    { "<leader>cR", "<cmd>TSToolsRenameFile<cr>", mode = "n", silent = true, desc = "Rename File" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
}
```

## 快捷键一览表

| 按键 | 作用 | 备注 |
|------|------|------|
| `<leader>co` | 组织导入 | 自动整理和排序 import 语句 |
| `<leader>cF` | 修复所有 | 修复所有可自动修复的问题 |
| `<leader>cR` | 重命名文件 | 重命名当前文件并更新引用 |

## 常用命令/用法

1. **组织导入**：`<leader>co` 自动整理和排序 import 语句
2. **修复问题**：`<leader>cF` 修复所有可自动修复的 TypeScript 问题
3. **重命名文件**：`<leader>cR` 重命名当前文件并自动更新所有引用
4. **类型检查**：提供实时的类型检查和错误提示
5. **代码补全**：增强的 TypeScript 代码补全功能

## 主要功能

- **导入管理**：自动整理、排序和优化 import 语句
- **代码修复**：自动修复常见的 TypeScript 问题
- **文件重命名**：智能重命名文件并更新所有引用
- **类型提示**：显示参数名、变量类型等内联提示
- **代码补全**：增强的智能代码补全

## 与现有插件的配合/注意事项

- **与 LSP 集成**：基于 TypeScript 语言服务器
- **与 conform.nvim 配合**：格式化功能由 conform 处理
- **与 Treesitter 配合**：提供语法高亮支持
- **文件类型限制**：仅在 TypeScript/JavaScript 文件中激活
- **避免重复格式化**：禁用内置格式化，使用 conform.nvim

## 配置说明

- **内联提示**：显示参数名、函数返回类型等
- **代码补全**：增强的补全功能
- **导入偏好**：相对路径导入
- **格式化禁用**：避免与 conform.nvim 冲突

## 故障排查

### 常见报错与解决

1. **命令不生效**
   - 确保在 TypeScript/JavaScript 文件中使用
   - 检查 TypeScript 语言服务器是否运行：`:LspInfo`
   - 确认文件类型正确：`:set filetype?`

2. **导入组织失败**
   - 检查项目是否有 `tsconfig.json`
   - 确认 TypeScript 版本兼容性
   - 查看错误信息：`:messages`

3. **重命名文件失败**
   - 确保有足够的文件系统权限
   - 检查是否有其他程序占用文件
   - 确认项目结构正确
