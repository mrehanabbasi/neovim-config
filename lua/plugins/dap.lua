return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", "<cmd> DapToggleBreakpoint <CR>", desc = "Add breakpoint at line" },
      {
        "<leader>dus",
        function()
          local widgets = require("dap.ui.widgets")
          local sidebar = widgets.sidebar(widgets.scopes)
          sidebar.open()
        end,
        desc = "Open debugging sidebar",
      },
    },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("which-key").add({
        {
          mode = "n",
          {
            "<leader>dgt",
            function()
              require("dap-go").debug_test()
            end,
            desc = "Debug go test",
          },
          {
            "<leader>dgl",
            function()
              require("dap-go").debug_last()
            end,
            desc = "Debug last go test",
          },
        },
      })
      -- vim.keymap.set("n", "<leader>dgt", function()
      --   require("dap-go").debug_test()
      -- end, { desc = "Debug go test" })
      -- vim.keymap.set("n", "<leader>dgl", function()
      --   require("dap-go").debug_last()
      -- end, { desc = "Debug last go test" })
    end,
  },
}
