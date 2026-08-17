local util = require 'custom.util'

local is_pio_project = vim.fn.filereadable 'platformio.ini' == 1

-- Install (and make available to `:packadd`) but do NOT source the plugin's
-- files yet: its autocommands need a PlatformIO project and fail without one.
util.add({ util.gh 'anurag3301/nvim-platformio.lua' }, { load = function() end })

-- Its dependencies are managed/loaded elsewhere in the config, but listing
-- them here guarantees they exist on disk for PlatformIO.
util.add { util.gh 'akinsho/toggleterm.nvim', util.gh 'nvim-lua/plenary.nvim', util.gh 'folke/which-key.nvim', util.gh 'nvim-treesitter/nvim-treesitter' }

-- Do not wire the plugin up outside of a PlatformIO project.
if not is_pio_project then return end

vim.g.pioConfig = {
  lsp = 'clangd', -- use the system clangd (/usr/bin/clangd)
  clangd_source = 'compiledb', -- generate compile_commands.json via compiledb
  picker_backend = 'ui_select', -- no telescope dependency needed
  menu_key = '<leader>\\', -- open the PlatformIO menu
  debug = false,
}

-- Source the plugin's files now that we're in a project, then set it up.
vim.cmd.packadd 'nvim-platformio.lua'
vim.g.platformioRootDir = vim.fn.getcwd()

local ok, platformio = pcall(require, 'platformio')
if ok then platformio.setup(vim.g.pioConfig) end
