local function has_golangci_config(ctx)
  local config_files = vim.fs.find({ ".golangci.yml", ".golangci.yaml" }, {
    upward = true,
    path = ctx.dirname,
    type = "file",
  })
  return #config_files > 0
end

return {
  formatters_by_ft = {
    lua = { "stylua" },
    go = function(bufnr)
      local ctx = { dirname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h") }
      if has_golangci_config(ctx) then
        return { "golangci_lint_fmt" }
      end
      return { "gofumpt", "goimports", "gci" }
    end,
    nix = { "nixfmt" },
  },

  formatters = {
    golangci_lint_fmt = {
      command = "golangci-lint",
      args = { "fmt", "--stdin", "--stdin-filename", "$FILENAME" },
      stdin = true,
    },
    gci = {
      command = "gci",
      args = {
        "write",
        "--skip-generated",
        "--custom-order",
        "-s", "standard",
        "-s", "localmodule",
        "-s", "default",
        "--",
        "$FILENAME",
      },
      stdin = false,
    },
  },
}
