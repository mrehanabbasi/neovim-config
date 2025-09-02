return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    opts.files = opts.files or {}
    opts.files.fd_opts = "--type f --hidden --follow --exclude vendor"
    return opts
  end,
}
