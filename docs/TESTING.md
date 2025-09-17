# Manual Verification Checklist

Use this walkthrough before sharing configuration changes or updating pinned plugins.

## Bootstrap
- `make deps` – confirm Lazy.nvim installs without errors and `lazy-lock.json` updates cleanly.
- `make health` – resolve any reported missing executables (Python, Node, clipboard providers) before proceeding.

## Clipboard Pipeline
- Inside a tmux pane or SSH session, yank a visual selection with `<leader>Y`; paste into a host terminal to ensure `osc52` forwarding works.
- Outside tmux, repeat the test and confirm no duplicate yanks appear in `:messages`.

## Folding & Navigation
- Open a file with nested functions and run `zM`, `zR`, then `zo`/`zc` on specific folds to verify `nvim-ufo` respects standard commands.
- Trigger `zc` after leaving insert mode to confirm folds stay in sync with Treesitter ranges.

## Language Servers
- For TypeScript or JavaScript, run `:TSToolsOrganizeImports` and ensure it succeeds without formatting the file (Conform handles formatting).
- In Lua files, check that diagnostics surface and `:Mason` lists expected servers after installation.

## UI & Notifications
- Trigger an error (e.g., `:lua error("debug")`) and verify `nvim-notify` renders a transient notification.
- Call `:TroubleToggle` and confirm diagnostics render with the expected keymaps documented in `docs/trouble.md`.

## Regression Notes
Document deviations or new manual steps in the relevant `docs/*.md` file plus a short note in the pull request so other contributors can reproduce your environment.
