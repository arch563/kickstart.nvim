local util = require 'custom.util'

util.add { util.gh 'obsidian-nvim/obsidian.nvim', { src = util.gh 'ibhagwan/fzf-lua' } }

-- The vault lives on a Windows drive (WSL), so the setup is wrapped in pcall:
-- on machines where that path does not exist, we skip obsidian instead of
-- crashing the config.
local ok, obsidian_err = pcall(require('obsidian').setup, {
  legacy_commands = false, -- this will be removed in 4.0.0
  ui = {
    enable = false,
  },
  workspaces = {
    {
      name = 'pkm',
      path = '/mnt/c/Users/ArchiePullan/OneDrive - Sirius Constellation Ltd/Documents/pkm',
    },
  },
  picker = { name = 'fzf-lua' },
  note_id_func = function(title) return title:gsub(' ', '-'):gsub('\\[\\^A-Za-z0-9-\\]', ''):lower() end,
})
if not ok then
  vim.notify(('obsidian.nvim not enabled: %s'):format(obsidian_err), vim.log.levels.WARN)
end