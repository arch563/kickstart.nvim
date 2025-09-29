return {
  'sindrets/diffview.nvim',
  lazy = true,
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    {
      '<leader>gdm',
      function()
        vim.cmd 'DiffviewOpen master'
      end,
      desc = 'diffview master',
    },
    {
      '<leader>gda',
      function()
        vim.ui.input({ promp = 'Branch for diff: ' }, function(branch)
          if branch and branch ~= '' then
            vim.cmd('DiffviewOpen ' .. branch)
          end
        end)
      end,
      desc = 'diffview compare with specific branch',
    },
    {
      '<leader>gdr',
      function()
        -- Change to the current file's directory
        local dir = vim.fn.expand '%:p:h'
        vim.cmd('tcd ' .. dir)

        -- Check if we're in a git repo
        local is_git_repo = vim.fn.system('git rev-parse --is-inside-work-tree'):gsub('%s+', '') == 'true'
        if not is_git_repo then
          vim.notify('Not inside a git repository!', vim.log.levels.ERROR)
          return
        end

        -- Get current branch
        local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):gsub('%s+', '')
        -- Get remote tracking branch
        local remote = vim.fn.system('git rev-parse --abbrev-ref --symbolic-full-name @{u}'):gsub('%s+', '')
        if remote == '' then
          vim.notify('No remote tracking branch found for ' .. branch, vim.log.levels.WARN)
          return
        end
        vim.cmd('DiffviewOpen ' .. remote)
      end,
      desc = 'Diffview: compare with remote tracking branch',
    },
  },
}
