return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{ "<cr>\\", function() Snacks.terminal.toggle() end, desc = "Open horizontal terminal split" },
		{ "<leader>gi", function() Snacks.picker.gh_issue() end,                  desc = "GitHub Issues (open)" },
		{ "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
		{ "<leader>gp", function() Snacks.picker.gh_pr() end,                     desc = "GitHub Pull Requests (open)" },
		{ "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end,    desc = "GitHub Pull Requests (all)" },
	},
	opts = {
		indent = {
			-- your indent configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		terminal = {},
		scratch = {
			-- your scratch configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		gh = {
			-- your gh configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		dashboard = {
			sections = {
				{ section = "header" },
				{
					pane = 2,
					section = "terminal",
					cmd = "colorscript -e square",
					height = 5,
					padding = 1,
				},
				{ section = "keys", gap = 1, padding = 1 },
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
					cmd = "git status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{ section = "startup" },
			},
		},

		picker = {
			sources = {
				gh_issue = {
					-- your gh_issue picker configuration comes here
					-- or leave it empty to use the default settings
				},
				gh_pr = {
					-- your gh_pr picker configuration comes here
					-- or leave it empty to use the default settings
				}
			}
		},
	},

}
