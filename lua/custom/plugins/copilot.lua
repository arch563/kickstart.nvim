return {
  'zbirenbaum/copilot.lua',
  lazy = true,
  cmd = 'Copilot',
  build = ':Copilot auth',
  event = 'BufReadPost',
  dependencies = {
    'copilotlsp-nvim/copilot-lsp', -- (optional) for NES functionality
  },
  opts = {
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
  },
}
