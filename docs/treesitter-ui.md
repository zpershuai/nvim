# Treesitter UI Enhancements

Visual helpers powered by Treesitter: delimiter coloring and context display.

## Plugins
- `HiPhish/rainbow-delimiters.nvim` – multi-color parentheses/brackets/braces.
- `nvim-treesitter/nvim-treesitter-context` – sticky context window for current scope.

## Usage
- Rainbow delimiters activate automatically when Treesitter highlighting is on.
- Context window appears at the top of the buffer while moving through nested scopes.

## Notes
- If colors look off, check your colorscheme highlight groups for `RainbowDelimiter*`.
- You can tweak context height or behavior in `lua/user/config/treesitter_context.lua`.

## Related Modules
- `lua/user/plugins/treesitter.lua`
- `lua/user/config/rainbow_delimiters.lua`
- `lua/user/config/treesitter_context.lua`
