-- 测试折叠功能的脚本
-- 使用方法：在 Neovim 中运行 :lua require('user.test_fold').test()

local M = {}

function M.test()
    print("=== 折叠功能测试 ===")
    
    -- 检查 ufo 是否加载
    local ok, ufo = pcall(require, "ufo")
    if not ok then
        print("❌ nvim-ufo 未加载")
        return
    end
    print("✅ nvim-ufo 已加载")
    
    -- 检查当前缓冲区的提供者
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    local has_lsp_fold = false
    for _, client in ipairs(clients) do
        if client.server_capabilities.foldingRangeProvider then
            has_lsp_fold = true
            print("✅ 检测到 LSP 折叠支持: " .. client.name)
            break
        end
    end
    
    if not has_lsp_fold then
        print("ℹ️  当前缓冲区无 LSP 折叠支持，将使用 treesitter/indent")
    end
    
    -- 检查折叠设置
    print("📋 当前折叠设置:")
    print("  foldcolumn: " .. vim.o.foldcolumn)
    print("  foldlevel: " .. vim.o.foldlevel)
    print("  foldenable: " .. tostring(vim.o.foldenable))
    
    -- 检查快捷键映射
    print("⌨️  检查快捷键映射:")
    local mappings = {
        "zo", "zc", "za", "zO", "zC", "zA", "zR", "zM", "zr", "zm"
    }
    
    for _, key in ipairs(mappings) do
        local ok, result = pcall(vim.fn.maparg, key, "n")
        if ok and result ~= "" then
            print("  ✅ " .. key .. " -> " .. result)
        else
            print("  ❌ " .. key .. " 未映射")
        end
    end
    
    -- 检查当前缓冲区的折叠状态
    local folds = vim.fn.getbufline(bufnr, 1, "$")
    local fold_count = 0
    
    for i, line in ipairs(folds) do
        if vim.fn.foldlevel(i) > 0 then
            fold_count = fold_count + 1
        end
    end
    
    print("📁 当前缓冲区折叠信息:")
    print("  总行数: " .. #folds)
    print("  可折叠行数: " .. fold_count)
    
    print("\n🎯 测试建议:")
    print("1. 尝试使用 zo 打开折叠")
    print("2. 尝试使用 zc 关闭折叠")
    print("3. 尝试使用 za 切换折叠")
    print("4. 尝试使用 zR 打开所有折叠")
    print("5. 尝试使用 zM 关闭所有折叠")
    
    print("\n⚠️  注意事项:")
    print("- pretty-fold.nvim 已禁用（兼容性问题）")
    print("- fold-preview.nvim 已禁用（依赖问题）")
    print("- 使用 nvim-ufo 的默认折叠显示")
    
    print("\n=== 测试完成 ===")
end

-- 快速测试函数
function M.quick_test()
    print("=== 快速折叠测试 ===")
    
    -- 检查基本设置
    print("foldcolumn: " .. vim.o.foldcolumn)
    print("foldlevel: " .. vim.o.foldlevel)
    print("foldenable: " .. tostring(vim.o.foldenable))
    
    -- 检查 ufo 状态
    local ok, ufo = pcall(require, "ufo")
    if ok then
        print("✅ nvim-ufo 已加载")
        
        -- 检查当前缓冲区的折叠提供者
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        local has_lsp_fold = false
        for _, client in ipairs(clients) do
            if client.server_capabilities.foldingRangeProvider then
                has_lsp_fold = true
                print("✅ LSP 折叠: " .. client.name)
                break
            end
        end
        
        if not has_lsp_fold then
            print("ℹ️  使用 treesitter/indent 折叠")
        end
    else
        print("❌ nvim-ufo 未加载")
    end
    
    print("=== 快速测试完成 ===")
end

return M
