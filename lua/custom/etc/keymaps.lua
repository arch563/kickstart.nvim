return {
	---vim.keymap.set({ 'n', 'v' }, 'mm', '<cmd>BookmarksMark<cr>', { desc = 'Mark current line into active BookmarkList.' }),
	---vim.keymap.set({ 'n', 'v' }, 'mo', '<cmd>BookmarksGoto<cr>', { desc = 'Go to bookmark at current active BookmarkList' }),
	---  vim.keymap.set({ 'n', 'v' }, 'mt', '<cmd>BookmarksTree<cr>', { desc = 'Open Bookmarks Tree' }),
	---  vim.keymap.set({ 'n', 'v' }, '<leader>ai', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle codecompanion chat' }),
}
