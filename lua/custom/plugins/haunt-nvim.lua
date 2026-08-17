local util = require 'custom.util'

util.add {
  util.gh 'TheNoeTrevino/haunt.nvim',
  util.gh 'ibhagwan/fzf-lua',
}

-- default config: change to your liking, or remove it to use defaults
require('haunt').setup {
  sign = '󱙝',
  sign_hl = 'DiagnosticInfo',
  virt_text_hl = 'HauntAnnotation', -- links to DiagnosticVirtualTextHint
  annotation_prefix = ' 󰆉 ',
  annotation_suffix = '',
  line_hl = nil,
  virt_text_pos = 'eol',
  data_dir = nil,
  per_branch_bookmarks = true,
  picker = 'fzf', -- "auto", "snacks", "telescope", or "fzf"
  picker_keys = { -- picker agnostic, we got you covered
    delete = { key = 'd', mode = { 'n' } },
    edit_annotation = { key = 'a', mode = { 'n' } },
  },
}

-- recommended keymaps, with a helpful prefix alias
local haunt_api = require 'haunt.api'
local haunt_picker = require 'haunt.picker'
local map = vim.keymap.set
local prefix = '<leader>m'

-- annotations
map('n', 'mm', function() haunt_api.annotate() end, { desc = 'Annotate' })
map('n', 'mt', function() haunt_api.toggle_annotation() end, { desc = 'Toggle annotation' })
map('n', prefix .. 'T', function() haunt_api.toggle_all_lines() end, { desc = 'Toggle all annotations' })
map('n', 'md', function() haunt_api.delete() end, { desc = 'Delete bookmark' })
map('n', prefix .. 'CC', function() haunt_api.clear_all() end, { desc = 'Delete all bookmarks' })

-- move
map('n', prefix .. 'p', function() haunt_api.prev() end, { desc = 'Previous bookmark' })
map('n', prefix .. 'n', function() haunt_api.next() end, { desc = 'Next bookmark' })

-- picker
map('n', prefix .. 'l', function() haunt_picker.show() end, { desc = 'Show Picker' })

-- quickfix
map('n', prefix .. 'q', function() haunt_api.to_quickfix() end, { desc = 'Send Hauntings to QF Lix (buffer)' })
map('n', prefix .. 'Q', function() haunt_api.to_quickfix { current_buffer = true } end, { desc = 'Send Hauntings to QF Lix (all)' })

-- yank
map('n', prefix .. 'y', function() haunt_api.yank_locations { current_buffer = true } end, { desc = 'Send Hauntings to Clipboard (buffer)' })
map('n', prefix .. 'Y', function() haunt_api.yank_locations() end, { desc = 'Send Hauntings to Clipboard (all)' })