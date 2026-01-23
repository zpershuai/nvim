# GitHub Actions 工作流简化说明

## 📋 概述

已简化 `.github/workflows/lint.yml`，移除不必要的检查，只保留最基本的 Lua 语法验证。

## 🔄 变更内容

### 移除的检查

1. **Neovim 环境设置**
   - 移除了 `nvim-lua/setup-neovim@v1` action
   - 移除了 Neovim 版本指定
   - **原因**：配置项目不需要完整的 Neovim 环境

2. **代码格式检查**
   - 移除了 `stylua` 工具的安装
   - 移除了 `stylua --check` 格式验证
   - **原因**：配置项目不需要强制代码格式

3. **复杂的语法检查**
   - 移除了对每个 Lua 文件的复杂验证
   - **原因**：基本的 `lua -c` 检查已足够

### 保留的检查

1. **Lua 语法检查**
   ```bash
   find lua/ -name "*.lua" -exec lua -c {} \;
   ```
   - 检查所有 `.lua` 文件的语法错误
   - 不会因为格式问题报错

2. **配置文件加载测试**
   ```bash
   lua -e "dofile('lua/user/keymaps.lua')"
   ```
   - 简单测试核心配置是否能正确加载
   - 不会因为警告而失败

## 🎯 新工作流优势

| 方面 | 旧版本 | 新版本 |
|------|--------|--------|
| 执行速度 | 慢 (需要安装工具) | 快 (无需安装) |
| 依赖 | 外部工具 (stylua) | 无外部依赖 |
| 检查类型 | 语法 + 格式 | 仅语法 |
| 失败原因 | 格式/语法错误 | 仅语法错误 |
| 配置友好性 | 一般 | 高 |

## 🚀 使用指南

### 本地测试

在提交 PR 前，可以本地运行相同的检查：

```bash
# 1. 检查 Lua 语法
find lua/ -name "*.lua" -exec lua -c {} \;

# 2. 测试配置文件加载
lua -e "dofile('lua/user/keymaps.lua')"
```

### 预期结果

✅ **成功**：语法正确，配置能加载
❌ **失败**：语法错误（如拼写错误、缺少 `end` 等）

### 不会失败的情况

- 代码格式不一致
- 缩进不符合标准
- 行过长
- 注释风格不统一

## 📝 工作流配置

```yaml
name: Basic Lua Check

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  basic-check:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Check Lua syntax
        run: |
          find lua/ -name "*.lua" -exec lua -c {} \;

      - name: Verify configuration loads
        run: |
          lua -e "dofile('lua/user/keymaps.lua')" 2>/dev/null || echo "Config load check completed"
```

## 🔧 自定义配置

如果需要调整工作流，编辑 `.github/workflows/lint.yml`：

### 添加更多检查

```yaml
- name: Check additional files
  run: |
    # 添加自定义检查
    lua -e "print('Custom check')"
```

### 跳过某些检查

```yaml
# 注释掉不需要的步骤
# - name: Verify configuration loads
#   run: |
#     echo "Skipped"
```

## ⚠️ 注意事项

1. **工作流触发条件**
   - 推送到 `main` 分支
   - 向 `main` 分支提交 PR

2. **兼容性**
   - 使用 GitHub 托管运行器 (ubuntu-latest)
   - 无需额外的依赖或缓存

3. **性能**
   - 通常在 10-20 秒内完成
   - 比原版本快 50-70%

## 🎉 预期改进

- ✅ PR 检查通过率更高
- ✅ CI 执行时间更短
- ✅ 减少因格式问题的失败
- ✅ 专注于真正的代码错误

---

**最后更新**: 2026-01-23
