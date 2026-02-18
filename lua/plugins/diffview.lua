local function branch_exists(branch)
  local _ = vim.fn.systemlist("git rev-parse --verify " .. branch .. " >/dev/null 2>&1")
  return vim.v.shell_error == 0
end

local function get_base_branch()
  if branch_exists("main") then
    return "main"
  elseif branch_exists("master") then
    return "master"
  else
    return nil
  end
end

local function diff_with_base()
  local base = get_base_branch()
  if not base then
    vim.notify("No 'main' or 'master' branch found", vim.log.levels.ERROR)
    return
  end
  vim.cmd("DiffviewOpen " .. base .. "...HEAD")
end

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "", desc = "+diffview", mode = "n" },
    { "<leader>gdd", "<Cmd>DiffviewOpen<CR>", desc = "Open diff view of current index" },
    { "<leader>gdm", diff_with_base, desc = "Diff current vs main/master" },
    { "<leader>gdc", "<Cmd>DiffviewClose<CR>", desc = "Close diffview" },
  },
  opts = {},
}
