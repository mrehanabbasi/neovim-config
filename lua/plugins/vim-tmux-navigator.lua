return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left (tmux)" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down (tmux)" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up (tmux)" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (tmux)" },
    { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate previous (tmux)" },
  },
}
