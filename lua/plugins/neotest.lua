return {
  {
    "nvim-neotest/neotest",
    ft = { "go" },
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          -- Here we can set options for neotest-golang, e.g.
          go_test_args = { "-v", "-race", "-count=1" },
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
