# AGENTS.md - Agentic Coding Guide

This document provides guidance for AI coding agents working with this Neovim configuration repository.

## Project Overview

This is a **LazyVim-based Neovim configuration** written entirely in Lua. It extends the LazyVim distribution with custom configurations for Go, TypeScript, Nix, Docker, Kubernetes, and other languages.

### Directory Structure

```
lua/
├── config/           # Core configuration modules
│   ├── lazy.lua      # lazy.nvim bootstrap and setup
│   ├── keymaps.lua   # Custom key mappings
│   ├── lsp.lua       # LSP servers config (servers + setup tables)
│   ├── conform.lua   # Formatter configurations (including Go)
│   ├── lint.lua      # Linter configurations
│   ├── neo-tree.lua  # Neo-tree file explorer settings
│   └── treesitter.lua # Treesitter parser configuration
└── plugins/          # Plugin specifications (lazy.nvim format)
```

## Build/Lint/Test Commands

```bash
# Format Lua files
stylua lua/                      # Format all
stylua --check lua/              # Check only

# Validate configuration
nvim --headless -c "luafile init.lua" -c "qa"   # Syntax check
nvim --headless -c "Lazy sync" -c "qa"          # Plugin check
```

**Manual testing**: Open Neovim, run `:checkhealth` and `:Lazy` to verify.

## Code Style Guidelines

### Formatting (stylua.toml)

- **Indentation**: 2 spaces
- **Line width**: 120 characters
- **Quotes**: Double quotes

### Naming Conventions

- **Files**: `kebab-case` (`neo-tree.lua`, `vim-tmux-navigator.lua`)
- **Variables/Functions**: `snake_case` (`go_mod_path`, `get_base_branch`)

### Module Patterns

**Plugin spec with external config:**
```lua
return {
  "neovim/nvim-lspconfig",
  opts = require("config.lsp"),
}
```

**Plugin spec extending LazyVim defaults:**
```lua
return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.go = { "gofumpt", "goimports" }
    return opts
  end,
}
```

### Error Handling

```lua
-- Check shell command exit status
local _ = vim.fn.systemlist("git rev-parse --verify " .. branch)
return vim.v.shell_error == 0

-- Notify with proper level
vim.notify("Error message", vim.log.levels.ERROR)

-- Nil-safe table access
new_config.settings.json.schemas = new_config.settings.json.schemas or {}
```

### Keymap Registration

Use which-key for grouped keymaps:
```lua
require("which-key").add({
  { mode = "n" },
  { "<leader>gd",  group = "diffview" },
  { "<leader>gdd", "<Cmd>DiffviewOpen<CR>", desc = "Open diff view" },
})
```

## Important Gotchas

1. **Check LazyVim first**: Many plugins are pre-configured by LazyVim. Check [LazyVim source](https://github.com/LazyVim/LazyVim) before adding new config.

2. **LazyVim extras**: Enable language support via `lazyvim.json`, not manual plugin config. Available extras: `lang.go`, `lang.typescript`, `lang.nix`, `dap.core`, etc.

3. **Formatting**: All formatting is handled by **conform.nvim** (`lua/config/conform.lua`), including Go (`gofumpt` + `goimports-reviser`).

4. **LSP config structure**: `lua/config/lsp.lua` has two tables:
   - `servers`: LSP server options (gopls, jsonls, yamlls, etc.)
   - `setup`: Custom setup functions per server

5. **NixOS**: Mason is disabled on NixOS. Tools must be in `$PATH` via Nix.

## Language Support

| Language   | LSP      | Formatter                    | Linter        |
|------------|----------|------------------------------|---------------|
| Go         | gopls    | gofumpt, goimports-reviser   | golangci-lint |
| Lua        | lua_ls   | stylua                       | -             |
| TypeScript | ts_ls    | prettier                     | eslint        |
| Nix        | nixd     | nixfmt                       | -             |
| YAML/JSON  | yamlls/jsonls | prettier                | -             |
| Docker     | dockerls | -                            | hadolint      |

**Schema support**: SchemaStore.nvim + custom K8s CRDs (ExternalSecrets, SecretStores, Istio).

## Common Tasks

### Add language support
1. Enable the LazyVim extra in `lazyvim.json` (e.g., `"lang.python"`)
2. Only add custom config if LazyVim defaults are insufficient

### Add LSP server configuration
Edit `lua/config/lsp.lua`:
- Add to `servers` table for options
- Add to `setup` table for custom setup logic

### Override LazyVim plugin
```lua
return {
  "existing/plugin",
  opts = function(_, opts)
    opts.new_setting = true
    return opts
  end,
}
```

### Disable a plugin
```lua
return { "plugin/to-disable", enabled = false }
```

**Key files**: `lazyvim.json` (extras config), `lazy-lock.json` (plugin versions - commit this), `lua/config/lsp.lua` (LSP configs), `lua/config/conform.lua` (all formatters).