local scrollview_config = require("config.scrollview")

return {
  "dstein64/nvim-scrollview",
  event = "VeryLazy",
  opts = scrollview_config.opts,
  config = function(_, opts)
    require("scrollview").setup(opts)
    scrollview_config.setup_highlights()
  end,
}
