return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- use latest release, remove to use latest commit
  dependencies = { 'ibhagwan/fzf-lua' },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
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
  },
}
