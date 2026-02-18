return {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt", "goimports-reviser" },
    nix = { "nixfmt" },
  },

  formatters = {
    ["goimports-reviser"] = {
      command = "goimports-reviser",
      args = function(self, ctx)
        -- Find nearest go.mod and extract module name
        local go_mod_path = vim.fs.find("go.mod", {
          upward = true,
          path = ctx.dirname,
          type = "file",
        })[1]

        local module_name = ""
        if go_mod_path then
          for line in io.lines(go_mod_path) do
            local match = line:match("^module%s+(.+)")
            if match then
              module_name = match
              break
            end
          end
        end

        return {
          "-output",
          "stdout",
          "-project-name",
          module_name,
          "-imports-order",
          "std,project,general,company",
          "-rm-unused",
          "-excludes",
          "vendor/",
          "-format",
          "-", -- read from stdin
        }
      end,
      stdin = true,
    },
  },
}
