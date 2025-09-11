local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local goimports_reviser = helpers.make_builtin({
  name = "goimports-reviser",
  method = null_ls.methods.FORMATTING,
  filetypes = { "go" },
  generator_opts = {
    command = "goimports-reviser",
    args = function(params)
      -- find nearest go.mod
      local start_dir = vim.fs.dirname(params.bufname)
      local go_mod_path = vim.fs.find("go.mod", {
        upward = true,
        path = start_dir,
        type = "file",
      })[1]

      local module_name = nil
      if go_mod_path then
        for line in io.lines(go_mod_path) do
          module_name = line:match("^module%s+(.+)")
          if module_name then
            break
          end
        end
      end

      return {
        "-output",
        "stdout", -- print to stdout for none-ls to capture
        "-project-name",
        module_name or "",
        "-imports-order",
        "std,project,general,company",
        "-rm-unused",
        "-excludes",
        "vendor/",
        "-format",
        "-", -- read from stdin
      }
    end,
    to_stdin = true,
  },
  factory = helpers.formatter_factory,
})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.gofumpt,
    -- null_ls.builtins.formatting.gofmt,
    goimports_reviser,
  },
})
