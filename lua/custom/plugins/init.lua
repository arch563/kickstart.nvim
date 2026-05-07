-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  require 'custom.plugins.conform-nvim',
  require 'custom.plugins.coverage-nvim',
  require 'custom.plugins.csvview-nvim',
  require 'custom.plugins.dashboard-nvim',
  require 'custom.plugins.flash-nvim',
  require 'custom.plugins.haunt-nvim',
  require 'custom.plugins.lazygit',
  require 'custom.plugins.markdown',
  require 'custom.plugins.persistence-nvim',
  require 'custom.plugins.trouble-nvim',
  require 'custom.plugins.sidekick-nvim',
}
