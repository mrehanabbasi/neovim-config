return {
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      always_show = {
        ".gitignore",
      },
      never_show = {
        ".git",
      },
    },
  },
  -- hide_root_node = true,
}
