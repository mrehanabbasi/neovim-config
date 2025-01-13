return {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },

    go = {
      -- "golines",
      -- "gofmt",
      -- "gofumpt",
      "goimports",
      -- "goimports-reviser"
    },

    nix = { "nixfmt" },
  },

  -- Not required for LazyVim
  -- format_on_save = {
  -- These options will be passed to conform.format()
  -- timeout_ms = 500,
  -- lsp_fallback = true,
  -- },
}
