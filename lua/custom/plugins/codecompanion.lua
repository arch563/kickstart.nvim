return {
	'olimorris/codecompanion.nvim',
	lazy = true,
	cmd = { 'CodeCompanionChat Toggle' },
	config = function()
		local ok, local_config = pcall(require, 'custom.plugins.codecompanion.local')
		if ok then
			local_config.setup()
		else
			require('codecompanion').setup {
				strategies = {
					chat = {
						adapter = 'copilot',
						model = 'Geimini 2.5 Pro',
					},
				},
				adapters = {
					http = {
						opts = {
							allow_insecure = true,
							proxy = 'http://webproxy-internal.metoffice.gov.uk:8080',
						}
					}
				}
			}
		end
	end,
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
}
