return {
  'stevearc/conform.nvim',
  config = function() 
	  local conform = require('conform')
conform.setup {
	  formatters_by_ft = {
	    lua = { "stylua" },
	    -- Conform will run multiple formatters sequentially
	    python = { "ruff"},
	    go = {"gofmt"},
	  },
	  format_on_save = function(bufnr)
			local ignore_filetypes = { "sql", "yaml", "yml" }
			if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				return
			end
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }

		end
		}
	end
}
