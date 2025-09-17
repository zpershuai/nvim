# Documentation Map

Contributor-facing references live here. Each plugin or integration gets its own markdown file with a consistent outline: prerequisites, key commands, troubleshooting, and optional tips.

## Key Files
- `clipboard.md` – OSC52 and system clipboard notes.
- `noice.md`, `notify.md`, `flash.md` – UI enhancements and notification handling.
- `project.md`, `oil.md` – project and file navigation helpers.
- `todo-comments.md`, `trouble.md` – diagnostics workflow.
- `typescript-tools.md` – language server tuning for TypeScript/JavaScript.
- `TESTING.md` – manual regression checklist referenced by the contributor guide.

## When Adding Docs
1. Follow the naming pattern (`kebab-case.md`) so `rg` searches are predictable.
2. Start with a short summary, then document required binaries or Neovim versions.
3. Include example commands or keymaps verbatim (wrapped in backticks) for easy copy/paste.
4. Link back to related modules in `lua/user/` so maintainers can find the implementation quickly.
