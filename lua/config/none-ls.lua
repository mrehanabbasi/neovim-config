local null_ls = require("null-ls")

local goimports_reviser = {
  name = "goimports-reviser",
  method = null_ls.methods.FORMATTING,
  filetypes = { "go" },
  generator = null_ls.generator({
    command = "goimports-reviser",
    args = function(params)
      -- Start searching for go.mod from the file's directory
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
        "-project-name",
        module_name or "",
        "-set-alias", -- optional: keep aliases grouped
        "-format",
        params.bufname,
      }
    end,
    to_stdin = false, -- goimports-reviser only works with filenames
  }),
}

null_ls.setup({
  sources = {
    goimports_reviser,
    -- (optional) chain stricter formatting
    -- none_ls.builtins.formatting.gofumpt,
  },
})
