return {
  {
    "mason-org/mason.nvim",
    enabled = function()
      return vim.fn.filereadable("/etc/NIXOS") == 0
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = function()
      return vim.fn.filereadable("/etc/NIXOS") == 0
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    enabled = function()
      return vim.fn.filereadable("/etc/NIXOS") == 0
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    enabled = function()
      return vim.fn.filereadable("/etc/NIXOS") == 0
    end,
  },
}
