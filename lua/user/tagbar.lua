local options = {
	tagbar_map_togglesort = "s",
	tagbar_sort = 0,
	tagbar_scopestrs = {
		class = "",
		struct = "",
		const = "\\uf8ff",
		constant = "\\uf8ff",
		enum = "",
		field = "\\uf30b",
		func = "",
		["function"] = "",
		getter = "\\ufab6",
		implementation = "\\uf776",
		interface = "\\uf7fe",
		map = "\\ufb44",
		member = "\\uf02b",
		method = "\\uf6a6",
		setter = "\\uf7a9",
		variable = "",
	},
}

for k, v in pairs(options) do
	vim.g[k] = v
end
