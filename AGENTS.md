# AGENTS.md — Neovim / LazyVim Configuration

## What this repo is

- A personal Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim).
- Entry point: `init.lua` → `require("config.lazy")`.
- Plugin specs live under `lua/plugins/`. `lua/config/` holds options, keymaps, autocmds, and the lazy.nvim bootstrap.

## LazyVim extras and plugin boundaries

- **Declarative extras** are in `lazyvim.json` (lang: angular, docker, json, markdown, python, sql, typescript, yaml; test.core; util.rest).
- **Hardcoded extras** are imported in `lua/config/lazy.lua`:
  - `lazyvim.plugins.extras.dap.core`
  - `lazyvim.plugins.extras.lang.java`
- Custom plugin files under `lua/plugins/` override or extend LazyVim defaults. The `example.lua` file is explicitly disabled (`if true then return {} end`) — do not treat it as active config.

## Java-specific toolchain quirks

- **jdtls + Lombok**: `lua/plugins/java.lua` automatically injects `-javaagent:<mason>/share/jdtls/lombok.jar` into jdtls `cmd` if the jar exists. Do not add a second Lombok argument.
- **DAP configs**: `lua/plugins/java.lua` adds an attach config for `localhost:8000` in addition to LazyVim’s default `5005`. Spring Boot remote debug example (port 5005) is documented in that file.
- **Formatter**: `google-java-format` is used with the `--aosp` flag (`lua/plugins/conform.lua`). This matches IntelliJ IDEA defaults, not standard Google style.
- **Mason auto-install**: `lua/plugins/mason.lua` pins `google-java-format`, `java-debug-adapter`, and `java-test`.

## Neotest configuration

- `lua/plugins/neotest.lua` configures the `neotest-java` adapter with:
  - `jvm_args = { "-Dapi.version=1.44" }`
  - `env = { API_VERSION = "1.44" }`
- `lua/plugins/neotest-java.lua` initializes the adapter on `ft = "java"`. Running `:NeotestJava setup` requires opening a `.java` file first.

## Notification filtering

- `lua/plugins/noice.lua` suppresses jdtls progress spam ("Processing", "Validate documents", "Publish diagnostics") via `noice.nvim` routes. If adding new LSP suppressions, use the same route pattern.

## Style and formatting

- **Lua**: `stylua.toml` uses 4 spaces and 120 column width. Do not assume 2-space indent.
- When editing plugin files, respect existing return-table style; some files use 2-space indent, others 4.

## Key files to read before changing behavior

| File | Why it matters |
|------|---------------|
| `lua/config/lazy.lua` | Bootstrap and spec imports (order of extras vs custom plugins) |
| `lazyvim.json` | Declarative LazyVim extras |
| `lua/plugins/java.lua` | Lombok injection, DAP attach configs |
| `lua/plugins/conform.lua` | Java formatter args (`--aosp`) |
| `lua/plugins/neotest.lua` | Java adapter JVM args / env |
| `lua/plugins/noice.lua` | Notification route patterns |
| `stylua.toml` | Lua formatter constraints |

## Common agent pitfalls

- Do not add `lang.java` to `lazyvim.json` extras — it is already hardcoded in `lazy.lua`.
- Do not add a manual Lombok `-javaagent` in `java.lua`; the existing `opts` function already injects it conditionally.
- Do not treat `example.lua` as active code.
- Editing `lazy-lock.json` manually is pointless; it is managed by lazy.nvim.
