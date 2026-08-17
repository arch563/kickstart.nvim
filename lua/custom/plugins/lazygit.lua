local util = require 'custom.util'

util.add {
  util.gh 'kdheepak/lazygit.nvim',
  util.gh 'nvim-lua/plenary.nvim',
}

-- Custom keymap: open LazyGit in the current file's directory in a new tab
vim.keymap.set('n', '<leader>lg', function()
  local dir = vim.fn.expand '%:p:h'
  vim.cmd 'LazyGitCurrentFile'
end, { desc = 'Open LazyGit in current file directory' })