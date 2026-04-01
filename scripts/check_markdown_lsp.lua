vim.cmd("edit docs/README.md")
vim.wait(500)

local filetype = vim.bo.filetype
if filetype ~= "markdown" then
    error(string.format("Expected markdown filetype, got %s", filetype))
end

local attached = {}
for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(attached, client.name)
end

for _, name in ipairs(attached) do
    if name == "lua_ls" then
        error("lua_ls should not attach to markdown buffers")
    end
end

print("Attached clients: " .. vim.inspect(attached))
