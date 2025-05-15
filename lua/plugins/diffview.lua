return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup()
    require("which-key").add({
      {
        mode = "n",
        { "<leader>gd", group = "diffview" },
        {
          "<leader>gdd",
          "<Cmd>DiffviewOpen<CR>",
          desc = "Open diff view of current index",
        },
        {
          "<leader>gdm",
          "<Cmd>DiffviewOpen master..HEAD<CR>",
          desc = "Open diff between current branch and master branch",
        },
        {
          "<leader>gdc",
          "<Cmd>DiffviewClose<CR>",
          desc = "Close diffview",
        },
      },
    })
  end,
}
