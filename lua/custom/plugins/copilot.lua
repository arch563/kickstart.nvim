local util = require 'custom.util'

util.add { util.gh 'zbirenbaum/copilot.lua', util.gh 'copilotlsp-nvim/copilot-lsp' }

require('copilot').setup {
  suggestion = {
    enabled = not vim.g.ai_cmp,
    auto_trigger = true,
    hide_during_completion = vim.g.ai_cmp,
    keymap = {
      accept = '<M-l>',
      next = '<M-]>',
      prev = '<M-[>',
    },
    filetypes = {
      markdown = true,
      python = true,
    },
  },
}