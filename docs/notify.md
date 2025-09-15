# nvim-notify - 通知系统

nvim-notify 是一个现代化的通知系统，提供美观的通知界面和通知历史管理功能。

## 安装方式

```lua
{
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  keys = {
    { "<leader>un", "<cmd>Telescope notify<cr>", mode = "n", silent = true, desc = "Notification History" },
    { "<leader>ud", "<cmd>lua require('notify').dismiss()<cr>", mode = "n", silent = true, desc = "Dismiss Notifications" },
  },
}
```

## 快捷键一览表

| 按键 | 作用 | 备注 |
|------|------|------|
| `<leader>un` | 通知历史 | 使用 Telescope 查看通知历史 |
| `<leader>ud` | 清除通知 | 清除当前显示的所有通知 |

## 常用命令/用法

1. **查看通知历史**：`<leader>un` 打开通知历史面板
2. **清除通知**：`<leader>ud` 清除当前显示的通知
3. **自动通知**：插件会自动显示 LSP、Git 等操作的通知
4. **通知类型**：支持不同级别的通知（ERROR、WARN、INFO、DEBUG）
5. **通知样式**：支持自定义通知的外观和动画

## 与现有插件的配合/注意事项

- **与 LSP 集成**：自动显示 LSP 操作的通知
- **与 Git 集成**：显示 Git 操作的通知
- **与 Telescope 配合**：使用 Telescope 查看通知历史
- **与 noice.nvim 配合**：提供更丰富的 UI 体验
- **性能优化**：使用 `VeryLazy` 事件，避免影响启动速度

## 配置说明

- **背景颜色**：`#000000` 黑色背景
- **帧率**：30 FPS 流畅动画
- **超时时间**：5 秒自动消失
- **最大宽度**：90% 屏幕宽度
- **最小宽度**：40% 屏幕宽度

## 故障排查

### 常见报错与解决

1. **通知不显示**
   - 检查插件是否正确安装：`:Lazy status`
   - 确认 `vim.notify` 已正确设置
   - 查看错误信息：`:messages`

2. **通知历史无法打开**
   - 确保 Telescope 已安装并配置
   - 检查 Telescope 的 notify 扩展是否可用
   - 尝试手动运行 `:Telescope notify`

3. **通知样式异常**
   - 检查终端是否支持所需特性
   - 确认颜色方案兼容性
   - 调整通知配置参数
