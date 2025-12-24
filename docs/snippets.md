# Snippets

Snippet support is provided by LuaSnip with a Telescope picker for quick insertion.

## Plugins
- `L3MON4D3/LuaSnip` – snippet engine.
- `rafamadriz/friendly-snippets` – curated snippet collection.
- `benfowler/telescope-luasnip.nvim` – browse and insert snippets via Telescope.

## Usage
- `<leader>fs` – open Telescope LuaSnip picker.
- In insert mode, snippet expansion is handled by the existing LuaSnip + nvim-cmp setup.

## Notes
- Snippet sources load from `friendly-snippets` using VSCode format.
- If you add custom snippets, place them under your LuaSnip config and reload the session.

## Related Modules
- `lua/user/cmp.lua`
- `lua/user/plugins/snippets.lua`
