# 折叠功能 (Folding)

本文档介绍了 Neovim 配置中的折叠功能，包括使用的插件、配置选项、快捷键和故障排除。

**注意**: 在某些 Neovim 版本中，pretty-fold.nvim 可能会出现兼容性问题。如果遇到类似 `dlsym(RTLD_DEFAULT, curwin_col_off): symbol not found` 的错误，请参考故障排除部分。

## 插件介绍

### nvim-ufo
[nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) 是一个现代化的折叠引擎，支持多种折叠提供者：
- LSP (Language Server Protocol)
- Treesitter
- Indent (缩进)

### promise-async
[promise-async](https://github.com/kevinhwang91/promise-async) 是 nvim-ufo 的依赖插件，提供异步处理能力。

### pretty-fold.nvim
[pretty-fold.nvim](https://github.com/anuvyklack/pretty-fold.nvim) 美化折叠显示，使折叠文本更易读。

### fold-preview.nvim
[fold-preview.nvim](https://github.com/anuvyklack/fold-preview.nvim) 提供折叠内容预览功能。

## 安装配置

在 `lua/user/plugins/fold.lua` 中的配置：

```lua
return {
  -- Ufo folding engine with dependencies
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    config = function()
      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })

      -- Set default fold options
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    keys = {
      { "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", mode = "n", silent = true, desc = "Open all folds" },
      { "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", mode = "n", silent = true, desc = "Close all folds" },
    },
  },

  -- Pretty fold display
  {
    "anuvyklack/pretty-fold.nvim",
    event = "BufReadPost",
    config = function()
      require("pretty-fold").setup({
        keep_indentation = false,
        fill_char = "─",
        sections = {
          left = {
            "content",
          },
          right = {
            "number_of_folded_lines",
            ": ",
            "percentage",
            " ──",
          },
        },
      })
    end,
  },

  -- Fold preview
  {
    "anuvyklack/fold-preview.nvim",
    dependencies = {
      "anuvyklack/pretty-fold.nvim",
    },
    event = "BufReadPost",
    config = function()
      require("fold-preview").setup({
        border = "rounded",
        width = 60,
        height = 15,
      })
    end,
    keys = {
      { "<leader>fp", "<cmd>lua require('fold-preview').togglePreview()<cr>", mode = "n", silent = true, desc = "Preview fold" },
    },
  },
}
```

## 快捷键

| 快捷键 | 模式 | 描述 |
|--------|------|------|
| `zR` | Normal | 打开所有折叠 |
| `zM` | Normal | 关闭所有折叠 |
| `<leader>fp` | Normal | 预览当前折叠内容 |

## 常用命令

| 命令 | 描述 |
|------|------|
| `zR` | 打开所有折叠 |
| `zM` | 关闭所有折叠 |
| `zo` | 打开当前折叠 |
| `zO` | 递归打开当前折叠 |
| `zc` | 关闭当前折叠 |
| `zC` | 递归关闭当前折叠 |
| `za` | 切换当前折叠开关 |
| `zA` | 递归切换当前折叠开关 |

## 与内置折叠的区别

Neovim 内置的折叠功能有以下几种方式：
1. manual (手动)
2. indent (缩进)
3. expr (表达式)
4. syntax (语法)
5. diff (差异)

本配置使用 nvim-ufo 插件的优势：
- 更好的性能
- 支持 LSP 和 Treesitter 提供的语义折叠
- 更美观的折叠显示
- 可预览折叠内容

## 故障排除

### Treesitter/LSP 不生效

1. 确保已安装对应语言的 Treesitter 解析器：
   ```vim
   :TSInstallInfo
   ```

2. 检查 LSP 服务器状态：
   ```vim
   :LspInfo
   ```

3. 验证文件类型是否正确：
   ```vim
   :set filetype?
   ```

### 折叠显示异常

1. 检查 fold 相关设置：
   ```vim
   :set foldcolumn?
   :set foldlevel?
   :set foldenable?
   ```

2. 重新加载配置：
   ```vim
   :source ~/.config/nvim/init.lua
   ```

3. 重启 Neovim

### 预览功能不工作

1. 确保所有依赖插件已正确安装：
   ```vim
   :Lazy
   ```

2. 检查插件健康状态：
   ```vim
   :checkhealth
   ```

### pretty-fold.nvim 兼容性问题

如果遇到 `dlsym(RTLD_DEFAULT, curwin_col_off): symbol not found` 错误，可以尝试以下解决方案：

1. 更新所有插件到最新版本：
   ```vim
   :Lazy update
   ```

2. 如果问题仍然存在，可以暂时禁用 pretty-fold 插件，在 `lua/user/plugins/fold.lua` 中注释掉 pretty-fold 部分：
   ```lua
   -- [[
   -- Pretty fold display - simplified configuration to avoid compatibility issues
   -- {
   --   "anuvyklack/pretty-fold.nvim",
   --   event = "BufReadPost",
   --   config = function()
   --     require("pretty-fold").setup({
   --       keep_indentation = false,
   --       fill_char = "─",
   --       sections = {
   --         left = {
   --           "content",
   --         },
   --         right = {
   --           "number_of_folded_lines",
   --           ": ",
   --           "percentage",
   --           " ──",
   --         },
   --       },
   --       ft_ignore = { "neogitstatus", "diff", "git", "gitcommit", "gitrebase", "NvimTree", "help" },
   --       -- Disable problematic features
   --       use_manual = false,
   --       -- Simplified setup for better compatibility
   --     })
   --   end,
   -- },
   -- ]]
   ```

3. 或者可以完全移除 pretty-fold，仅使用 nvim-ufo 的默认折叠显示。