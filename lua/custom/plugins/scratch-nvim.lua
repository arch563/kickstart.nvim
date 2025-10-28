return {
  'LintaoAmons/scratch.nvim',
  event = 'VeryLazy', 
  dependencies = {
    {"ibhagwan/fzf-lua"}, --optional: if you want to use fzf-lua to pick scratch file. Recommanded, since it will order the files by modification datetime desc. (require rg)
    {"nvim-telescope/telescope.nvim"}, -- optional: if you want to pick scratch file by telescope
    {"folke/snacks.nvim"}, -- optional: if you want to pick scratch file by snacks picker
    {"stevearc/dressing.nvim"} -- optional: to have the same UI shown in the GIF
  },
  keys = {
    {'<leader><C-s>', '<cmd>Scratch<cr>',},
  },
}
