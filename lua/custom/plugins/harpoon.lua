return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    require('harpoon'):setup { settings = { save_on_toggle = true } }
  end,

  keys = {
    {
      '<leader>has',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'shoot harpoon',
    },
    {
      '<leader>ham',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'harpoon quick menu',
    },
    {
      '<leader>ha1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'harpoon to file 1',
    },
    {
      '<leader>ha2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'harpoon to file 2',
    },
    {
      '<leader>ha3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'harpoon to file 3',
    },
    {
      '<leader>ha4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'harpoon to file 4',
    },
    {
      '<leader>ha5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = 'harpoon to file 5',
    },
    {
      '<leader>han',
      function()
        require('harpoon'):list():next()
      end,
      desc = 'harpoon to next',
    },
    {
      '<leader>hap',
      function()
        require('harpoon'):list():prev()
      end,
      desc = 'harpoon to previous',
    },
    {
      '<leader>har',
      function()
        local harpoon = require 'harpoon'
        local list = harpoon:list()
        for i = 5, 1, -1 do
          harpoon:list():remove(i)
        end
      end,
      desc = 'harpoon remove all (1-5)',
    },
  },
}
