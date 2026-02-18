return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      local custom = require("config.treesitter")
      return vim.tbl_deep_extend("force", opts, custom)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },
}
