return {
	'nvim-neotest/neotest',
	dependencies = {
		'nvim-neotest/nvim-nio',
		'nvim-lua/plenary.nvim',
		'antoinemadec/FixCursorHold.nvim',
		'nvim-treesitter/nvim-treesitter',
	},
	lazy = true,
	keys = {
		{ '<leader>ns', '<cmd>Neotest summary<cr>', desc = 'open neotest summary' },
		{ '<leader>nr', '<cmd>Neotest run<cr>',     desc = 'run current file' },
	},

	config = function()
		require('neotest').setup {
			adapters = {
				require 'neotest-python' {
					args = { '--log-level', 'INFO' },
					---         python = 'C:/workspace/.venv/scripts/python',
				},
			},
			log_level = 1,
		}
	end,
}
