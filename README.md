# Neovim Configuration

Opinionated Neovim setup focused on a modular Lazy.nvim plugin layout, consistent Lua ergonomics, and documentation that doubles as a contributor manual. The configuration targets Neovim 0.9+ on macOS or Linux and assumes the repo is checked out at `~/.config/nvim`.

## Quick Start
1. Back up any existing `~/.config/nvim` directory.
2. Clone this repository into `~/.config/nvim`.
3. Run `make deps` to install pinned plugins (`make help` lists additional targets).
4. Launch `nvim` and wait for Lazy.nvim to finish bootstrapping. The status line displays progress; close Neovim once to ensure lockfiles are written.

## Repository Layout
- `init.lua` wires Lazy.nvim and loads every module under `lua/user/`.
- `lua/user/plugins/` groups Lazy specs by domain (UI, editor, diagnostics, files, sessions, clipboard, TypeScript). Supporting configuration now lives in `lua/user/config/`, keeping declarations slim and reusable.
- `lua/user/lsp/` maintains language-server handlers and server-specific settings.
- `docs/` contains per-plugin notes (`docs/` + `README.md` indexes them) and integration guides such as `docs/typescript-tools.md`.
- `AGENTS.md` captures contribution standards, while `LSP_SETUP.md` records language tooling prerequisites.
- `formatter/google-style.clang-format` mirrors the external formatter configuration expected by `conform.nvim`.

## Daily Workflow
- `make check` runs a headless Lazy sync followed by `:checkhealth`; use it before sending pull requests.
- Manual verification steps for high-risk plugins (clipboard, folding, LSP, UI) are documented in `docs/TESTING.md`.
- For formatting, rely on `:ConformFormat` and keep Lua code at four-space indentation (`lua/user/options.lua` enforces this). Module filenames remain `snake_case`, exported keys mirror upstream plugin APIs, and new in-repo docs should follow the tone set in the existing `docs/*.md` files.

## Further Reading
- `CLAUDE.md` – Claude-specific onboarding.
- `AGENTS.md` – contributor workflow and review checklist.
- `docs/` – plugin deep dives, troubleshooting, and shortcuts.
- `LSP_SETUP.md` – language-server bootstrap instructions.
