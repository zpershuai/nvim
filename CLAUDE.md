# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### Plugin Management
```bash
# Sync plugins (install missing plugins)
:Lazy sync

# Update all plugins to latest version
:Lazy update

# Clean unused plugins
:Lazy clean

# Install plugins headlessly (for scripts/automation)
make deps
```

### LSP Management
```vim
# Open Mason to install language servers
:Mason

# Check LSP status
:LspInfo

# Restart LSP server
:LspRestart

# View diagnostics
:lua vim.diagnostic.open_float()
```

### Code Formatting
```vim
# Format with conform.nvim (primary formatter)
:ConformFormat

# Format with LSP fallback
:leader>lf  # (Space + l + f)
```

### Testing & Health Checks
```bash
# Run comprehensive health check
make check       # Runs deps + health
make health      # Just :checkhealth
make lock        # Refresh lazy-lock.json with current plugin revisions

# Performance profiling
:StartupTime    # Requires vim-startuptime plugin
```

### Maintenance Commands
```bash
# Update lazy-lock.json after plugin changes
make lock
```

## High-Level Architecture

### Plugin Management Structure
- **Manager**: Lazy.nvim (modern, performant plugin manager)
- **Organization**: Modular configuration in `lua/user/plugins/`:
  - `clipboard.lua` - OSC52 and local clipboard integration
  - `diagnostics.lua` - Diagnostic tools (trouble, breadcrumbs)
  - `editor.lua` - Core editor enhancements (autopairs, comments)
  - `files.lua` - File management (nvim-tree, telescope)
  - `fold.lua` - Code folding (pretty-fold)
  - `session.lua` - Session management (possession)
  - `typescript.lua` - TypeScript-specific tools
  - `ui.lua` - UI components (lualine, barbar, colorschemes)

### LSP Configuration
- **API**: Uses Neovim 0.11+ native `vim.lsp.config` API (migrated from nvim-lspconfig)
- **Entry**: `lua/user/lsp/init.lua` - LSP module loader
- **Handlers**: `lua/user/lsp/handlers.lua` - Common LSP event handlers
- **Configs**: `lua/user/lsp/configs.lua` - Server setup using vim.lsp.config
- **Settings**: `lua/user/lsp/settings/` - Per-language server configurations
- **Servers**: Uses Mason for installation, configured servers include:
  - `ts_ls` (TypeScript/JavaScript)
  - `eslint` (JavaScript/TypeScript linting)
  - `jsonls` (JSON)
  - `html` (HTML)
  - `lua_ls` (Lua)
  - `clangd` (C/C++)

### Key Mapping Conventions
- **Leader Key**: `<Space>` (configured in `lua/user/keymaps.lua`)
- **Categories**:
  - `<leader>f*` → File operations (find files, live grep, buffers)
  - `<leader>l*` → LSP functions (format, info, diagnostics navigation)
  - `<leader>t*` → Terminal/tools
  - `<leader>w*` → Window operations
  - `<leader>g*` → Git operations

### Initialization Flow
1. `init.lua` - Entry point with `vim.loader.enable()` for performance
2. `lua/user/options.lua` - Basic Neovim options
3. `lua/user/keymaps.lua` - Global key mappings
4. `lua/user/lazy.lua` - Lazy.nvim configuration
5. Direct module loading (all loaded sequentially):
   - Core: `colorscheme`, `cmp`, `lsp`, `nvim-web-devicons`, `telescope`, `treesitter`
   - Editor: `autopairs`, `comment`, `gitsigns`, `nvim-tree`, `indentline`
   - UI: `lualine`, `barbar`, `alpha`, `whichkey`
   - Tools: `toggleterm`, `neogit`, `aerial`, `spectre`, `tmux`, `diffview`, `dired`
   - Formatters: `formatter`, `conform`
   - Special: `leetcode`, `clipboard.init()`
   - Autocommands: `autocommands`

### Module Loading Pattern
- `init.lua` directly requires all modules in sequence
- Plugin specs are organized in `lua/user/plugins/` by domain
- LSP config uses new `vim.lsp.config` API (Neovim 0.11+)

### Special Features
- **Clipboard**: OSC52 integration for SSH/tmux environments + local clipboard
- **Formatting**: Primary use of `conform.nvim` with Prettier/ESLint integration, LSP as fallback
- **Code Folding**: `pretty-fold` with custom configuration for better readability
- **Session Management**: `possession.nvim` for session persistence
- **Performance**: `vim.loader.enable()` replaces impatient.nvim for faster startup

### Development Patterns
- All Lua files use 4-space indentation
- Module filenames in `snake_case`
- Plugin configurations separated by domain into separate files
- LSP settings separated by language into dedicated files
- Conventional commits format for git messages (see `AGENTS.md`)

### Important Files
- `init.lua` - Main configuration entry point
- `lua/user/plugins.lua` - Consolidates all plugin specifications
- `lua/user/lsp/configs.lua` - LSP server configurations
- `Makefile` - Build automation and maintenance commands
- `lazy-lock.json` - Pinned plugin versions (commit this)