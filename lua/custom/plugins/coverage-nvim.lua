return {
	"andythigpen/nvim-coverage",
	dependencies = { 'nvim-lua/plenary.nvim', 'andythigpen/nvim-coverage' },
	config = function()
		require("coverage").setup({
			commands = true, -- create commands
			highlights = {
				-- customize highlight groups created by the plugin
				covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
				uncovered = { fg = "#F07178" },
			},
			signs = {
				-- use your own highlight groups or text markers
				covered = { hl = "CoverageCovered", text = "▎" },
				uncovered = { hl = "CoverageUncovered", text = "▎" },
			},
			summary = {
				-- customize the summary pop-up
				min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
			},
			lang = {
				python = {
					coverage_command = "uv run coverage json --fail-under=0 -q -o -", -- generates XML report
				},
			},
			auto_reload = true,
			debug = true
		})
	end
}
