return {
  require('codecompanion').setup {

    adapters = {
      http = {
        opts = {
          allow_insecure = true,
          proxy = 'http://webproxy-internal.metoffice.gov.uk:8080',
        },
      },
    },
  },
}
