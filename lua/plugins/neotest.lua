return {
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          go_test_args = { "-v", "-cover", "-json", "-count=1" },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        },
      },
    },
  },
  {
    "fredrikaverpil/neotest-golang",
    ft = { "go" },
    event = "VeryLazy",
    dependencies = {
      "leoluz/nvim-dap-go",
    },
  },
}
