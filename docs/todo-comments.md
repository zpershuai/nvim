# Todo-comments.nvim - TODO 注释管理

Todo-comments.nvim 是一个智能的 TODO 注释管理插件，可以高亮显示代码中的 TODO、FIXME、HACK 等注释，并提供快速导航功能。

## 安装方式

```lua
{
  "folke/todo-comments.nvim",
  keys = {
    { "<leader>tT", "<cmd>TodoTelescope<cr>", mode = "n", silent = true, desc = "Todo Telescope" },
    { "]t", function() require("todo-comments").jump_next() end, mode = "n", silent = true, desc = "Next TODO" },
    { "[t", function() require("todo-comments").jump_prev() end, mode = "n", silent = true, desc = "Previous TODO" },
  },
}
```

## 快捷键一览表

| 按键 | 作用 | 备注 |
|------|------|------|
| `<leader>tT` | 打开 TODO 搜索 | 使用 Telescope 搜索所有 TODO |
| `]t` | 下一个 TODO | 跳转到下一个 TODO 注释 |
| `[t` | 上一个 TODO | 跳转到上一个 TODO 注释 |

## 常用命令/用法

1. **搜索 TODO**：`<leader>tT` 打开 Telescope 搜索所有 TODO 注释
2. **快速导航**：使用 `]t` 和 `[t` 在 TODO 之间快速跳转
3. **高亮显示**：自动高亮显示不同类型的注释
4. **过滤搜索**：在 Telescope 中可以按类型过滤 TODO
5. **跳转到位置**：在搜索结果中按 `<CR>` 跳转到对应位置

## 支持的注释类型

- **TODO**：待办事项
- **FIXME**：需要修复的问题
- **HACK**：临时解决方案
- **WARN**：警告信息
- **PERF**：性能优化
- **NOTE**：重要说明
- **TEST**：测试相关

## 与现有插件的配合/注意事项

- **与 Telescope 集成**：使用 Telescope 进行搜索和过滤
- **与 Treesitter 配合**：支持多种编程语言的注释语法
- **与 LSP 集成**：可以显示在诊断面板中
- **性能优化**：使用懒加载，只在需要时激活

## 故障排查

### 常见报错与解决

1. **TODO 不显示高亮**
   - 检查文件类型是否支持
   - 确认 Treesitter 解析器已安装
   - 重启 Neovim 或重新加载配置

2. **快捷键不生效**
   - 检查是否与其他插件冲突
   - 确认 `]t` 和 `[t` 没有被其他插件占用
   - 查看 `:verbose map ]t` 确认映射状态

3. **Telescope 搜索无结果**
   - 确保项目中有 TODO 注释
   - 检查注释格式是否正确（如 `// TODO:` 或 `# TODO:`）
   - 尝试手动运行 `:TodoTelescope` 命令
