local util = require 'custom.util'

util.add { util.gh 'MeanderingProgrammer/render-markdown.nvim', util.gh 'nvim-treesitter/nvim-treesitter', util.gh 'nvim-tree/nvim-web-devicons' }

require('render-markdown').setup {}