return {
	'olimorris/codecompanion.nvim',
	lazy = true,
	keys = { '<leader>ai', '<cmd>CodeCompanionChat Toggle<cr>' },
	cmd = { 'CodeCompanionChat Toggle' },
	opts = {
		strategies = {
			-- Change the default chat adapter and model
			chat = {
				adapter = 'copilot',
				model = 'gpt-4.1',
			},
		},
	},
	config = function()
		local ok = pcall(require, 'plugins.codecompanion.local')
		if not ok then
			require('codecompanion').setup {
				strategies = {
					chat = {
						adapter = 'copilot',
						model = 'gpt-4.1',
					},
				},
			}
		end
	end,

	dependencies = {
		'nvim-lua/plenary.nvim',
	},
}
