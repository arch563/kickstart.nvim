return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    -- Custom keymap: open LazyGit in the current file's directory in a new tab
    {
      '<leader>lg',
      function()
        local dir = vim.fn.expand '%:p:h'
        vim.cmd 'LazyGitCurrentFile'
      end,
      desc = 'Open LazyGit in current file directory',
    },
  },
}
