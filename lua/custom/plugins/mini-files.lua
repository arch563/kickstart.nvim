return {
	'nvim-mini/mini.files',
	keys = { { '\\', '<cmd>lua MiniFiles.open()<cr>' } },
	require('mini.files').setup(),

}
