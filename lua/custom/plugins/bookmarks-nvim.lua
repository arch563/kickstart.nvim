-- with lazy.nvim
return {
  'LintaoAmons/bookmarks.nvim',
  -- pin the plugin at specific version for stability
  -- backup your bookmark sqlite db when there are breaking changes (major version change)
  lazy = true,
  keys = {
    { 'mm', '<cmd>BookmarksMark<cr>', desc = 'Mark current line into active BookmarkList.' },
    { 'mo', '<cmd>BookmarksGoto<cr>', desc = 'Go to bookmark at current active BookmarkList' },
    { 'mt', '<cmd>BookmarksTree<cr>', desc = 'Open Bookmarks Tree' },
  },
  tag = '3.2.0',
  dependencies = {
    { 'kkharji/sqlite.lua' },
    { 'nvim-telescope/telescope.nvim' }, -- currently has only telescopes supported, but PRs for other pickers are welcome
    { 'stevearc/dressing.nvim' }, -- optional: better UI
    { 'GeorgesAlkhouri/nvim-aider' }, -- optional: for Aider integration
  },
  config = function()
    local opts = { signs = { mark = {
      color = 'yellow',
      line_bg = '#00FF0000.',
    } } } -- check the "./lua/bookmarks/default-config.lua" file for all the options
    require('bookmarks').setup(opts) -- you must call setup to init sqlite db
  end,
}
