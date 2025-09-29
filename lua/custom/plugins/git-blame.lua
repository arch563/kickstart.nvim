return {
  'f-person/git-blame.nvim',
  lazy = true,
  event = 'VeryLazy',
  opts = {
    enabled = true,
    message_template = ' <summary> • <date> • <author> • <<sha>>',
    date_format = '%m-%d-%Y %H:%M:%S',
    virtual_text_column = 1,
  },
}
