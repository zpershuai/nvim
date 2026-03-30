# ts_ls - TypeScript / JavaScript LSP

当前配置已经迁移到 `ts_ls`（`typescript-language-server`），不再依赖 `typescript-tools.nvim`。

## 安装方式

`mason-lspconfig.nvim` 会确保安装并启用 `ts_ls`。`ts_ls` 依赖 `typescript-language-server` 和 `typescript`，Mason 会一起处理。

## 快捷键一览表

| 按键 | 作用 | 备注 |
|------|------|------|
| `<leader>co` | 组织导入 | 调用 `ts_ls` 的 `_typescript.organizeImports` |
| `<leader>cF` | 修复所有 | 触发 `source.fixAll` 代码动作 |
| `<leader>cR` | 重命名文件 | 调用 `workspace/willRenameFiles` 并同步更新引用 |

## 常用命令/用法

1. **组织导入**：`<leader>co`
2. **修复问题**：`<leader>cF`
3. **重命名文件**：`<leader>cR`
4. **查看状态**：`:LspInfo`
5. **检查安装**：`:Mason`

## 主要功能

- **导入管理**：自动整理 import
- **代码修复**：通过 `source.fixAll` 执行可用修复
- **文件重命名**：重命名文件并应用 workspace edit
- **类型提示**：启用 TypeScript / JavaScript inlay hints
- **代码补全**：使用 `ts_ls` 的补全能力

## 与现有插件的配合/注意事项

- **与 LSP 集成**：基于 `ts_ls`
- **与 conform.nvim 配合**：格式化功能由 conform 处理
- **与 Treesitter 配合**：提供语法高亮支持
- **文件类型限制**：仅在 TypeScript/JavaScript 文件中激活
- **避免重复格式化**：禁用内置格式化，使用 conform.nvim

## 配置说明

- **内联提示**：显示参数名、函数返回类型等
- **代码补全**：增强导入与函数调用补全
- **导入偏好**：相对路径导入
- **格式化禁用**：避免与 conform.nvim 冲突

## 故障排查

### 常见报错与解决

1. **打开 JS/TS 文件时报 `Cannot find tsserver executable`**
   - 说明旧的 `typescript-tools.nvim` 路径仍在生效，更新后重启 Neovim
   - 用 `:Lazy sync` 清理未使用插件

2. **`ts_ls` 没有启动**
   - 检查 `:LspInfo`
   - 检查 `:Mason` 中是否已安装 `ts_ls`
   - 查看 `:messages`

3. **重命名文件失败**
   - 确认目标路径不存在
   - 确认目标目录可写
   - 确认项目中的 TypeScript 服务已附着到当前 buffer
