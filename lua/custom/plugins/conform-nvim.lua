return {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local conform = require 'conform'
		conform.setup {
			formatters_by_ft = {
				python = { 'ruff' },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = 'fallback',
			},
		}
		vim.api.nvim_create_autocmd('BufWritePre', {
			pattern = '*',
			callback = function(args)
				require('conform').format { bufnr = args.buf }
			end,
		})
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 10000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
