# Performance Tools

Startup and runtime profiling helpers for diagnosing slow boot or heavy runtime costs.

## Plugins
- `dstein64/vim-startuptime` – measure startup time and plugin load costs.
- `stevearc/profile.nvim` – profile runtime performance hotspots.

## Usage
- `:StartupTime` to generate the startup report.
- `:StartupTime --help` for available flags.
- `:ProfileStart` to begin profiling.
- `:ProfileStop` to end profiling and write results.
- `:Profile` to open the profile report.

## Notes
- `profile.nvim` writes output under Neovim's data directory; check messages if the report path is needed.
- Consider running `:StartupTime` after plugin changes or `make lock` to compare regressions.

## Related Modules
- `lua/user/plugins/performance.lua`
- `lua/user/config/profile.lua`
