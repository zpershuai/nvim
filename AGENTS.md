# Repository Guidelines

## Project Structure & Module Organization
The Neovim entrypoint is `init.lua`, which wires everything in `lua/user/`. Plugin specs stay slim inside `lua/user/plugins/`, while reusable setup logic now lives in `lua/user/config/` (for example `config/trouble.lua`, `config/typescript.lua`). Shared subsystems such as LSP (`lua/user/lsp/`) and formatters (`lua/user/formatter/`) remain grouped by concern. Reference material for contributors belongs in `docs/`—one markdown file per plugin, indexed by `docs/README.md`. Keep locks (`lazy-lock.json`) and meta guides (`LSP_SETUP.md`, `CLAUDE.md`) under version control to document supported tooling.

## Build, Test, and Development Commands
Run `make deps` after cloning to install pinned plugins (the target wraps `nvim --headless "+Lazy! sync" +qa`). Follow it with `make health` before reviewing PRs; both commands are listed in `make help`. When adjusting formatters or LSP, open `:Mason` to confirm servers install cleanly and regenerate `lazy-lock.json` with `make lock`.

## Coding Style & Naming Conventions
Lua sources prefer spaces with a logical width of four as enforced by `options.lua`. Use double quotes for strings unless an embedded quote makes single quotes clearer. Module filenames remain lowercase snake_case (e.g. `toggleterm.lua`), while exported tables use camelCase keys that match plugin APIs. Run `:ConformFormat` (backed by `conform.nvim`) on modified buffers and update `formatter/google-style.clang-format` only when the external toolchain changes.

## Testing Guidelines
Automated tests are not currently wired, so rely on functional checks. For new plugins, run `nvim --headless "+Lazy load <PluginName>" +qa` and watch `:messages` for errors or follow the flows recorded in `docs/TESTING.md`. Exercise key mappings added in `lua/user/keymaps.lua` and rerun `make health` after changing system integrations (clipboard, terminals, LSP servers). Document coverage expectations in the relevant `docs/*.md` entry when manual verification is required.

## Commit & Pull Request Guidelines
Follow the Conventional Commit prefix style used in history (`feat:`, `fix:`, `chore:` plus concise, sentence-case summaries). Group related Lua and doc changes in a single commit to keep lockfile updates traceable. Each pull request should outline motivation, list touched modules, and call out required manual steps (screenshots for UI tweaks, commands for new tool installs). Link upstream issues where possible and note any follow-up tasks to keep the configuration reproducible.
