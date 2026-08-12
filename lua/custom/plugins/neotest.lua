return {
  lazy = true,
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
  },
  keys = {
    {
      '<leader>tt',
      function() require('neotest').run.run() end,
      desc = 'Neotest: run nearest test',
    },
    {
      '<leader>tf',
      function() require('neotest').run.run(vim.fn.expand '%') end,
      desc = 'Neotest: run current file',
    },
    {
      '<leader>ta',
      function() require('neotest').run.run(vim.loop.cwd()) end,
      desc = 'Neotest: run all tests (cwd)',
    },
    {
      '<leader>tl',
      function() require('neotest').run.run_last() end,
      desc = 'Neotest: run last test',
    },
    {
      '<leader>ts',
      function() require('neotest').summary.toggle() end,
      desc = 'Neotest: toggle summary',
    },
    {
      '<leader>to',
      function() require('neotest').output.open { enter = true, auto_close = true } end,
      desc = 'Neotest: open output',
    },
    {
      '<leader>tO',
      function() require('neotest').output_panel.toggle() end,
      desc = 'Neotest: toggle output panel',
    },
    {
      '<leader>tS',
      function() require('neotest').run.stop() end,
      desc = 'Neotest: stop running tests',
    },
  },
  opts = function()
    return {
      adapters = {
        require 'neotest-python' {
          python = '.venv/bin/python',
          args = { '-vv' },
        },
      },
    }
  end,
}
