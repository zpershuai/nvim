# Trouble.nvim - 诊断信息管理

Trouble.nvim 是一个强大的诊断信息管理插件，提供统一的界面来查看和管理 LSP 诊断、引用、定义等信息。

## 安装方式

```lua
{
  "folke/trouble.nvim",
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>", mode = "n", silent = true, desc = "Trouble Toggle" },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", mode = "n", silent = true, desc = "Workspace Diagnostics" },
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", mode = "n", silent = true, desc = "Document Diagnostics" },
    { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", mode = "n", silent = true, desc = "LSP References" },
  },
}
```

## 快捷键一览表

| 按键 | 作用 | 备注 |
|------|------|------|
| `<leader>xx` | 切换 Trouble 面板 | 默认显示工作区诊断 |
| `<leader>xw` | 工作区诊断 | 显示整个工作区的诊断信息 |
| `<leader>xd` | 文档诊断 | 显示当前文档的诊断信息 |
| `<leader>xr` | LSP 引用 | 显示当前符号的所有引用 |

## 常用命令/用法

1. **查看诊断信息**：`<leader>xx` 打开 Trouble 面板
2. **跳转到问题**：在 Trouble 面板中按 `<CR>` 或 `<Tab>` 跳转到对应位置
3. **分屏查看**：按 `<C-x>` 在分屏中打开，`<C-v>` 在垂直分屏中打开
4. **关闭面板**：按 `q` 关闭 Trouble 面板
5. **刷新内容**：按 `r` 刷新诊断信息

## 与现有插件的配合/注意事项

- **与 LSP 集成**：自动显示 LSP 服务器的诊断信息
- **与 Telescope 配合**：可以通过 Telescope 的 `trouble` 扩展进行搜索
- **与 Git 集成**：支持显示 Git 相关的诊断信息
- **性能优化**：使用懒加载，只在需要时激活

## 故障排查

### 常见报错与解决

1. **诊断信息不显示**
   - 确保 LSP 服务器正常运行
   - 检查 `:LspInfo` 确认服务器状态
   - 重启 LSP 服务器：`:LspRestart`

2. **快捷键不生效**
   - 检查是否与其他插件冲突
   - 确认 leader 键设置正确：`:echo mapleader`

3. **面板无法打开**
   - 检查插件是否正确安装：`:Lazy status`
   - 查看错误信息：`:messages`
   - 重新同步插件：`:Lazy sync`
