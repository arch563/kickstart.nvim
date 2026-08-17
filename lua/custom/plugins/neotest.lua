local util = require 'custom.util'

util.add {
  util.gh 'nvim-neotest/neotest',
  util.gh 'nvim-neotest/nvim-nio',
  util.gh 'antoinemadec/FixCursorHold.nvim',
  util.gh 'nvim-treesitter/nvim-treesitter',
  util.gh 'nvim-neotest/neotest-python',
}

require('neotest').setup {
  adapters = {
    require 'neotest-python' {
      python = '.venv/bin/python',
      args = { '-vv' },
    },
  },
}

vim.keymap.set('n', '<leader>tt', function() require('neotest').run.run() end, { desc = 'Neotest: run nearest test' })
vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand '%') end, { desc = 'Neotest: run current file' })
vim.keymap.set('n', '<leader>ta', function() require('neotest').run.run(vim.loop.cwd()) end, { desc = 'Neotest: run all tests (cwd)' })
vim.keymap.set('n', '<leader>tl', function() require('neotest').run.run_last() end, { desc = 'Neotest: run last test' })
vim.keymap.set('n', '<leader>ts', function() require('neotest').summary.toggle() end, { desc = 'Neotest: toggle summary' })
vim.keymap.set('n', '<leader>to', function() require('neotest').output.open { enter = true, auto_close = true } end, { desc = 'Neotest: open output' })
vim.keymap.set('n', '<leader>tO', function() require('neotest').output_panel.toggle() end, { desc = 'Neotest: toggle output panel' })
vim.keymap.set('n', '<leader>tS', function() require('neotest').run.stop() end, { desc = 'Neotest: stop running tests' })