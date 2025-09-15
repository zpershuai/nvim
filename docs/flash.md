# flash.nvim - 快速跳转

flash.nvim 是一个智能的快速跳转插件，提供基于 Treesitter 的精确跳转功能。

## 安装方式

```lua
{
  "folke/flash.nvim",
  keys = {
    { "<leader>fj", "<cmd>Flash<cr>", mode = "n", silent = true, desc = "Flash Jump" },
    { "<leader>fJ", "<cmd>Flash Treesitter<cr>", mode = "n", silent = true, desc = "Flash Treesitter" },
  },
}
```

## 快捷键一览表

| 按键 | 作用 | 备注 |
|------|------|------|
| `<leader>fj` | Flash 跳转 | 标准跳转模式 |
| `<leader>fJ` | Flash Treesitter | 基于 Treesitter 的跳转 |

## 常用命令/用法

1. **标准跳转**：`<leader>fj` 激活 Flash 跳转模式
2. **Treesitter 跳转**：`<leader>fJ` 基于语法树的精确跳转
3. **字符跳转**：支持单字符和多字符跳转
4. **标签跳转**：显示跳转标签，按标签快速跳转
5. **模糊匹配**：支持模糊匹配跳转

## 主要特性

- **智能跳转**：基于 Treesitter 的精确跳转
- **标签显示**：清晰的跳转标签
- **多种模式**：支持字符、单词、Treesitter 等模式
- **模糊匹配**：支持模糊搜索跳转
- **性能优化**：高效的跳转算法

## 与现有插件的配合/注意事项

- **与 Treesitter 配合**：利用语法树进行精确跳转
- **与 Telescope 配合**：可以结合使用进行文件内搜索
- **与 mini.ai 配合**：增强文本对象识别
- **避免冲突**：与传统的 `f`/`F`/`t`/`T` 键位不冲突
- **性能考虑**：使用懒加载，避免影响启动速度

## 配置说明

- **Treesitter 模式**：启用基于语法树的跳转
- **标签样式**：清晰的跳转标签显示
- **匹配模式**：支持多种匹配模式
- **性能优化**：优化的跳转算法

## 故障排查

### 常见报错与解决

1. **跳转不生效**
   - 检查 Treesitter 是否正确安装
   - 确认文件类型支持 Treesitter
   - 查看错误信息：`:messages`

2. **标签不显示**
   - 检查终端是否支持所需特性
   - 确认颜色方案兼容性
   - 调整标签显示配置

3. **性能问题**
   - 检查文件大小是否过大
   - 确认 Treesitter 解析器性能
   - 调整跳转范围限制
