return {
	'mfussenegger/nvim-dap-python',
	-- stylua: ignore
	keys = {
		{ "<leader>dPt", function() require('dap-python').test_method({ config = { justMyCode = false } }) end, desc = "Debug Method", ft = "python" },
		{ "<leader>dPc", function() require('dap-python').test_class({ config = { justMyCode = false } }) end, desc = "Debug Class", ft = "python" },
	},
	config = function()
		require('dap-python').setup 'uv'
		require('dap-python').test_runner = 'pytest'
	end,
}
