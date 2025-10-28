return {
  'arch563/task-decomposer',
  dependencies = {
    'kkharji/sqlite.lua',
    'folke/snacks.nvim',
  },
  config = function()
    require('task-decomposer').setup {
      -- Optional: customize keymaps
      keymaps = {
        toggle_tree = 'gtt',
        add_task = 'gta',
      },
    }
  end,
}
