local util = require 'custom.util'

util.add { util.gh 'folke/trouble.nvim' }

require('trouble').setup {}

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP Definitions / references / ... (Trouble)' })
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })

local group = vim.api.nvim_create_augroup('TroubleQuickfixAutoOpen', { clear = true })

-- quickfix-producing commands (:grep, :vimgrep, :make, :helpgrep, etc.)
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = group,
  pattern = '[^l]*',
  callback = function()
    vim.cmd 'Trouble qflist open'
    vim.cmd 'cclose'
  end,
})

-- location-list-producing commands (:lgrep, :lvimgrep, :lhelpgrep, etc.)
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = group,
  pattern = 'l*',
  callback = function()
    vim.cmd 'Trouble loclist open'
    vim.cmd 'lclose'
  end,
})