# Neovim from scratch

**Important Update** When I initially created this repo I didn't anticipate the amount of breaking changes, if you'd like to use the same basic config as this one as a base I recommend my new repo: [nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide)

Each video will be associated with a branch so checkout the one you are interested in, you can follow along with this [playlist](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ).

## Try out this config

Make sure to remove or move your current `nvim` directory

**IMPORTANT** Requires [Neovim v0.8.0]](https://github.com/neovim/neovim/releases).  [Upgrade](#upgrade-to-latest-release) if you're on an earlier version. 
```
git clone https://github.com/LunarVim/Neovim-from-scratch.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed 

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim) 

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```
  sudo apt install xsel
  ```

- On Arch Linux

  ```
  sudo pacman -S xsel
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```
  pip install pynvim
  ```

- Neovim node support

  ```
  npm i -g neovim
  ```
---

**NOTE** make sure you have [node](https://nodejs.org/en/) installed, I recommend a node manager like [fnm](https://github.com/Schniz/fnm).

### Upgrade to latest release

Assuming you [built from source](https://github.com/neovim/neovim/wiki/Building-Neovim#quick-start), `cd` into the folder where you cloned `neovim` and run the following commands. 
```
git pull
make distclean && make CMAKE_BUILD_TYPE=Release
sudo make install
nvim -v
```

## Plugins

This configuration includes a comprehensive set of plugins organized by functionality:

### 诊断和问题管理
- [trouble.nvim](docs/trouble.md) - 诊断信息管理
- [todo-comments.nvim](docs/todo-comments.md) - TODO 注释管理

### UI 增强
- [nvim-notify](docs/notify.md) - 通知系统
- [noice.nvim](docs/noice.md) - 增强 UI 体验
- [dressing.nvim](docs/dressing.md) - UI 增强
- [nvim-colorizer.lua](docs/colorizer.md) - 颜色高亮

### 代码开发
- [typescript-tools.nvim](docs/typescript-tools.md) - TypeScript 开发工具
- [nvim-surround](docs/nvim-surround.md) - 文本环绕操作
- [flash.nvim](docs/flash.md) - 快速跳转

### 文件管理
- [oil.nvim](docs/oil.md) - 文件资源管理器
- [project.nvim](docs/project.md) - 项目管理

### 轻量增强
- [mini.nvim](docs/mini.md) - 轻量增强工具套件
- [persistence.nvim](docs/persistence.md) - 会话管理

### 核心插件
- **Lazy.nvim** - 插件管理器
- **which-key.nvim** - 快捷键提示
- **nvim-lspconfig** - LSP 配置
- **mason.nvim** - LSP 服务器管理
- **conform.nvim** - 代码格式化
- **nvim-treesitter** - 语法高亮
- **telescope.nvim** - 模糊搜索
- **nvim-tree** - 文件树
- **gitsigns.nvim** - Git 集成
- **lualine.nvim** - 状态栏

> The computing scientist's main challenge is not to get confused by the complexities of his own making. 

\- Edsger W. Dijkstra
