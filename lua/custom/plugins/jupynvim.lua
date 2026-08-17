local util = require 'custom.util'

util.add { util.gh 'sheng-tse/jupynvim' }

-- Runs the plugin's install script once (creates its Python venv, etc.).
util.build('jupynvim', function(dir)
  local install = loadfile(vim.fs.joinpath(dir, 'lua', 'jupynvim', 'install.lua'))
  if install then install().run({ dir = dir }) end
end)

require('jupynvim').setup {
  log_level = 'info',
  image_renderer = 'placeholder', -- "placeholder", "kitty", or "chafa"
}