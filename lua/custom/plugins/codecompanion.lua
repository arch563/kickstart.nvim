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
  config = function()
    require('codecompanion').setup {
      adapters = {
        http = {
          opts = {
            allow_insecure = true,
            proxy = 'http://webproxy-internal.metoffice.gov.uk:8080',
          },
        },
      },
    }
  end,

  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
