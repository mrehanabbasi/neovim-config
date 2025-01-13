return {
  ensure_installed = {
    "vim",
    "lua",
    "vimdoc",
    -- web
    "html",
    "css",
    "javascript",
    "jsdoc",
    "typescript",
    "tsx",
    -- data
    "json",
    "json5",
    "jsonc",
    "yaml",
    "toml",
    "xml",
    "markdown",
    "markdown_inline",
    "sql",
    -- nix
    "nix",
    -- build
    "make",
    "cmake",
    -- git
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    -- docker
    "dockerfile",
    -- shell
    "bash",
    "diff",
    -- go
    "go",
    "gomod",
    "gosum",
    "gowork",
    "gotmpl",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
    filetypes = { "html", "xml" },
  },
}
