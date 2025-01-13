return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- dependencies = { "windwp/nvim-ts-autotag" },
    opts = function()
      return require("config.treesitter")
    end,
  },
}
