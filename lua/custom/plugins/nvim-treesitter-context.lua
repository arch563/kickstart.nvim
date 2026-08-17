local util = require 'custom.util'

util.add { util.gh 'nvim-treesitter/nvim-treesitter-context', util.gh 'nvim-treesitter/nvim-treesitter' }

require('treesitter-context').setup()