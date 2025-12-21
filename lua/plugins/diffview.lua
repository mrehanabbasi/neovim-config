return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup()

    local function branch_exists(branch)
      -- This runs "git rev-parse --verify <branch>"
      -- and returns true/false based on exit code
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
      -- Diff default branch with current HEAD
      vim.cmd("DiffviewOpen " .. base .. "...HEAD")
    end

    require("which-key").add({
      {
        mode = "n",
        { "<leader>gd",  group = "diffview" },
        { "<leader>gdd", "<Cmd>DiffviewOpen<CR>",  desc = "Open diff view of current index" },
        { "<leader>gdm", diff_with_base,           desc = "Diff current vs main/master" },
        { "<leader>gdc", "<Cmd>DiffviewClose<CR>", desc = "Close diffview" },
      },
    })
  end,
}
