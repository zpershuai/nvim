# 剪贴板系统 - 本地与远程复制方案

本配置实现了智能的剪贴板系统，支持本地系统剪贴板和 SSH/tmux 环境的 OSC52 回退方案。

## 方案概要

### 本地环境
- **系统剪贴板**：使用 `unnamedplus` 寄存器
- **支持操作**：`"+y`、`"+p` 等标准 Vim 剪贴板操作
- **自动检测**：基于 `has('clipboard')` 检测系统剪贴板支持

### SSH/tmux 环境
- **OSC52 协议**：使用 `ojroques/nvim-osc52` 插件
- **工作原理**：通过终端转义序列将内容发送到本地剪贴板
- **自动回退**：检测到 SSH 或 tmux 环境时自动启用

## 依赖要求

### macOS
- ✅ **默认支持**：系统剪贴板无需额外配置
- ✅ **OSC52 支持**：iTerm2、Alacritty、WezTerm 默认支持

### Linux
- **系统剪贴板**：需要安装以下之一
  ```bash
  # Ubuntu/Debian
  sudo apt install xclip xsel
  
  # Arch Linux
  sudo pacman -S xclip xsel
  
  # Fedora
  sudo dnf install xclip xsel
  ```
- **OSC52 支持**：Alacritty、WezTerm 默认支持

### Windows
- ✅ **默认支持**：系统剪贴板无需额外配置
- ✅ **OSC52 支持**：Windows Terminal、Alacritty 支持

## 快捷键一览表

| 模式 | 快捷键 | 功能 | 环境 |
|------|--------|------|------|
| Normal | `<leader>Y` | 复制到系统剪贴板（操作符模式） | 本地/远程 |
| Normal | `<leader>yY` | 复制当前行到系统剪贴板 | 本地/远程 |
| Visual | `<leader>Y` | 复制选中内容到系统剪贴板 | 本地/远程 |

## 使用方法

### 本地环境
1. **复制文本**：`<leader>Y` + 文本对象（如 `iw`、`ap`、`$`）
2. **复制整行**：`<leader>yY`
3. **复制选中**：选中文本后按 `<leader>Y`
4. **粘贴**：使用 `"+p` 或系统粘贴快捷键

### SSH/tmux 环境
1. **自动检测**：系统自动检测 SSH/tmux 环境
2. **透明使用**：快捷键与本地环境完全一致
3. **OSC52 传输**：内容通过终端协议传输到本地剪贴板

## tmux 配置

在 `~/.tmux.conf` 中添加以下配置：

```bash
# 启用剪贴板支持
set -g set-clipboard on

# 可选：确保 OSC52 支持
set -ga terminal-overrides ',*:Ms=\\E]52;c;%p1%s\\7'
```

## 终端支持

### 默认支持 OSC52 的终端
- **Alacritty**：✅ 默认支持
- **iTerm2**：✅ 默认支持
- **WezTerm**：✅ 默认支持
- **Windows Terminal**：✅ 默认支持

### 需要手动启用的终端
- **Terminal.app**：需要安装 iTerm2 或使用其他终端
- **GNOME Terminal**：需要安装支持 OSC52 的终端
- **Konsole**：需要安装支持 OSC52 的终端

## 环境检测

系统会自动检测以下环境变量：
- `SSH_CONNECTION`：SSH 连接环境
- `SSH_TTY`：SSH 终端环境
- `TMUX`：tmux 会话环境

检测逻辑：
```lua
local is_ssh = (os.getenv("SSH_CONNECTION") or os.getenv("SSH_TTY")) ~= nil
local is_tmux = os.getenv("TMUX") ~= nil
local has_clip = vim.fn.has("clipboard") == 1
```

## 常见问题

### 1. 无法复制到系统剪贴板

**问题**：本地环境无法复制
**解决方案**：
- 检查系统剪贴板支持：`:echo has('clipboard')`
- 安装必要的工具：`xclip` 或 `xsel`（Linux）
- 重启 Neovim

### 2. SSH 环境复制不工作

**问题**：SSH 环境中复制内容无法到达本地剪贴板
**解决方案**：
- 检查终端是否支持 OSC52
- 确认 tmux 配置正确
- 检查网络连接和终端设置

### 3. tmux 中复制失败

**问题**：在 tmux 会话中复制不工作
**解决方案**：
- 添加 tmux 配置：`set -g set-clipboard on`
- 重启 tmux 会话
- 检查终端和 tmux 版本兼容性

### 4. Wayland 环境问题

**问题**：Wayland 下剪贴板不工作
**解决方案**：
- 安装 `wl-clipboard`：`sudo apt install wl-clipboard`
- 设置环境变量：`export WAYLAND_DISPLAY=wayland-0`
- 重启 Neovim

### 5. WSL 环境问题

**问题**：WSL 中剪贴板不工作
**解决方案**：
- 安装 Windows 剪贴板工具：`sudo apt install xclip`
- 使用 Windows Terminal 或支持 OSC52 的终端
- 检查 WSL 版本和配置

### 6. 多跳 SSH 问题

**问题**：通过多跳 SSH 连接时复制不工作
**解决方案**：
- 确保所有中间节点都支持 OSC52
- 检查 SSH 配置和代理设置
- 考虑使用本地端口转发

### 7. 远程开发环境

**问题**：VS Code Remote SSH 等环境中复制不工作
**解决方案**：
- 使用支持 OSC52 的终端
- 配置远程开发环境的剪贴板设置
- 考虑使用本地开发环境

## 调试信息

### 检查环境状态
```vim
:lua require("user.clipboard").init()
```

### 查看检测结果
启动时会显示环境检测信息：
```
Clipboard: Local (SSH:false, TMUX:false, CLIP:true)
Clipboard: OSC52 (SSH:true, TMUX:false, CLIP:true)
```

### 手动测试
```vim
" 测试系统剪贴板
:echo has('clipboard')

" 测试 OSC52
:lua require("osc52").copy("test")
```

## 性能优化

- **懒加载**：OSC52 插件使用 `VeryLazy` 事件
- **智能检测**：只在需要时启用相应功能
- **最小配置**：避免不必要的功能影响性能

## 兼容性说明

- **Neovim 版本**：需要 0.8.0 或更高版本
- **终端要求**：支持 OSC52 的现代终端
- **系统要求**：macOS 10.12+、Linux（主流发行版）、Windows 10+
