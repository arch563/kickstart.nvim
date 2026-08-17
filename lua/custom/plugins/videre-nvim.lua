local util = require 'custom.util'

util.add { util.gh 'Owen-Dechow/videre.nvim', util.gh 'Owen-Dechow/graph_view_yaml_parser', util.gh 'Owen-Dechow/graph_view_toml_parser', util.gh 'a-usr/xml2lua.nvim' }

require('videre').setup {
  box_style = 'sharp',
}