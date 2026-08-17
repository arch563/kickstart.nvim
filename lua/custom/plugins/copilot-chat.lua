local util = require 'custom.util'

util.add {
  util.gh 'CopilotC-Nvim/CopilotChat.nvim',
  util.gh 'nvim-lua/plenary.nvim',
}

-- Optional dependency for faster tokenisation, only built once.
util.build('CopilotChat.nvim', function(dir)
  if vim.fn.executable 'make' ~= 1 then return end
  util.shell(dir, 'make tiktoken')
end)

pcall(require('CopilotChat').setup, {
  model = 'gpt-5.3-codex',
  trusted_tools = { 'file', 'glob', 'grep' },
})