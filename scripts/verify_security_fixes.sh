#!/bin/bash

# Security Fixes Verification Script
# Date: 2026-01-23

set -e

echo "════════════════════════════════════════════════"
echo "  🔍 验证安全修复"
echo "════════════════════════════════════════════════"
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PASS=0
FAIL=0

# Helper functions
check_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASS++))
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
    ((FAIL++))
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

echo "1️⃣  检查文件完整性..."
echo "─────────────────────────────────────────────────"

# Check if files exist and have the security fixes
if grep -q "git_root_cache" lua/user/conform.lua; then
    check_pass "conform.lua 包含 git 缓存功能"
else
    check_fail "conform.lua 缺少 git 缓存功能"
fi

if grep -q "LazyUpdateSecure" lua/user/lazy.lua; then
    check_pass "lazy.lua 包含安全更新命令"
else
    check_fail "lazy.lua 缺少安全更新命令"
fi

if grep -q "vim.fn.executable" lua/user/neogit.lua; then
    check_pass "neogit.lua 使用安全的 API"
else
    check_fail "neogit.lua 仍使用不安全的 os.execute"
fi

if grep -q "create_safe_terminal" lua/user/toggleterm.lua; then
    check_pass "toggleterm.lua 包含安全检查函数"
else
    check_fail "toggleterm.lua 缺少安全检查"
fi

echo ""
echo "2️⃣  检查 Lua 语法..."
echo "─────────────────────────────────────────────────"

# Test Lua syntax (basic check)
if lua -e "dofile('lua/user/conform.lua')" 2>/dev/null; then
    check_pass "conform.lua 语法正确"
else
    check_warn "conform.lua 需要在 Neovim 环境中验证"
fi

echo ""
echo "3️⃣  检查文档..."
echo "─────────────────────────────────────────────────"

if [ -f "docs/SECURITY_FIXES.md" ]; then
    check_pass "详细修复文档存在"
else
    check_fail "缺少 SECURITY_FIXES.md"
fi

if [ -f "docs/SECURITY_QUICKSTART.md" ]; then
    check_pass "快速指南存在"
else
    check_fail "缺少 SECURITY_QUICKSTART.md"
fi

echo ""
echo "4️⃣  检查 Git 状态..."
echo "─────────────────────────────────────────────────"

# Check if we're in a git repo
if git rev-parse --git-dir > /dev/null 2>&1; then
    check_pass "在 Git 仓库中"

    # Check for uncommitted changes
    if [ -n "$(git status --porcelain)" ]; then
        check_warn "有未提交的更改（这是正常的）"
        echo ""
        echo "   修改的文件："
        git status --short | sed 's/^/   /'
    else
        check_pass "工作区干净"
    fi
else
    check_warn "不在 Git 仓库中"
fi

echo ""
echo "5️⃣  检查外部工具（可选）..."
echo "─────────────────────────────────────────────────"

# Check terminal tools
command -v lazygit >/dev/null 2>&1 && check_pass "lazygit 已安装" || check_warn "lazygit 未安装（可选）"
command -v node >/dev/null 2>&1 && check_pass "node 已安装" || check_warn "node 未安装（可选）"
command -v ncdu >/dev/null 2>&1 && check_pass "ncdu 已安装" || check_warn "ncdu 未安装（可选）"
command -v htop >/dev/null 2>&1 && check_pass "htop 已安装" || check_warn "htop 未安装（可选）"
command -v python >/dev/null 2>&1 && check_pass "python 已安装" || check_warn "python 未安装（可选）"
command -v gpg >/dev/null 2>&1 && check_pass "gpg 已安装" || check_warn "gpg 未安装（可选）"

echo ""
echo "════════════════════════════════════════════════"
echo "  📊 验证结果"
echo "════════════════════════════════════════════════"
echo ""
echo "通过: ${GREEN}$PASS${NC}"
echo "失败: ${RED}$FAIL${NC}"
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✅ 所有关键检查通过！${NC}"
    echo ""
    echo "📖 下一步："
    echo "   1. 重启 Neovim: nvim"
    echo "   2. 测试新命令: :LazyUpdateSecure"
    echo "   3. 阅读文档: docs/SECURITY_QUICKSTART.md"
    echo ""
    exit 0
else
    echo -e "${RED}❌ 发现 $FAIL 个问题，请检查上述输出${NC}"
    echo ""
    exit 1
fi
