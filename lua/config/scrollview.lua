local M = {}

M.opts = {
  signs_on_startup = {
    "cursor",
    "diagnostics",
    "folds",
    "loclist",
    "marks",
    "quickfix",
    "search",
    "spell",
  },
}

-- Colorblind-friendly highlight colors (red-green colorblindness safe)
function M.setup_highlights()
  vim.api.nvim_set_hl(0, "ScrollViewDiagnosticsError", { fg = "#CC79A7" }) -- Magenta/Pink
  vim.api.nvim_set_hl(0, "ScrollViewDiagnosticsWarn", { fg = "#E69F00" }) -- Orange
  vim.api.nvim_set_hl(0, "ScrollViewDiagnosticsInfo", { fg = "#56B4E9" }) -- Cyan
  vim.api.nvim_set_hl(0, "ScrollViewDiagnosticsHint", { fg = "#0072B2" }) -- Blue
  vim.api.nvim_set_hl(0, "ScrollViewSearch", { fg = "#F0E442" }) -- Yellow
  vim.api.nvim_set_hl(0, "ScrollViewMarks", { fg = "#88CCEE" }) -- Sky blue
  vim.api.nvim_set_hl(0, "ScrollViewCursor", { fg = "#FFFFFF" }) -- White
end

return M
