return {
  'olimorris/codecompanion.nvim',
  lazy = true,
  cmd = { 'CodeCompanionChat Toggle' },
  opts = {
    strategies = {
      -- Change the default chat adapter and model
      chat = {
        adapter = 'copilot',
        model = 'gpt-4.1',
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
