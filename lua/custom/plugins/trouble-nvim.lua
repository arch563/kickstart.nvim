return {
  'folke/trouble.nvim',
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
  config = function(_, opts)
    require('trouble').setup(opts)

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
  end,
}
