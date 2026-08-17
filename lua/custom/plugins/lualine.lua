local util = require 'custom.util'

util.add { util.gh 'nvim-lualine/lualine.nvim' }

require('lualine').setup {
  options = {
    theme = 'auto',
    globalstatus = true,
    icons_enabled = vim.g.have_nerd_font,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { { 'branch', icons_enabled = vim.g.have_nerd_font } },
    lualine_c = {
      -- Sidekick: Copilot status icon
      {
        function() return ' ' end,
        color = function()
          local ok, status = pcall(function() return require('sidekick.status').get() end)
          if ok and status then return status.kind == 'Error' and 'DiagnosticError' or status.busy and 'DiagnosticWarn' or 'Special' end
          return 'Special'
        end,
        cond = function()
          local ok, status = pcall(function() return require('sidekick.status').get() end)
          return ok and status ~= nil
        end,
      },
      {
        'diff',
        -- symbols_used = { added = '  ', modified = '󰝤 ', removed = '  ' },
      },
      {
        'diagnostics',
        sources = { 'nvim_diagnostic', 'nvim_lsp' },
        symbols = { error = '󰅚 ', warn = '󰀪 ', info = '󰋽 ', hint = '󰌶 ' },
      },
      'filename',
      'searchcount',
    },
    lualine_x = {
      -- Opencode agent status (busy spinner / idle checkmark)
      {
        function() return require('custom.opencode-status').component() end,
        cond = function() return require('custom.opencode-status').has_session() end,
        color = function()
          local oc = require('custom.opencode-status')
          return oc.busy and 'DiagnosticWarn' or 'Special'
        end,
      },
      -- Sidekick: CLI session status
      {
        function()
          local cli = require('sidekick.status').cli()
          return ' ' .. (#cli > 1 and #cli or '')
        end,
        cond = function()
          local ok, cli = pcall(function() return require('sidekick.status').cli() end)
          return ok and type(cli) == 'table' and #cli > 0
        end,
        color = function()
          local ok = pcall(function() return require('sidekick.status').cli() end)
          return ok and 'Special' or nil
        end,
      },
      'encoding',
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
