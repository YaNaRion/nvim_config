vim.pack.add {
  { src = 'https://github.com/kndndrj/nvim-dbee' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
}

require('dbee').install()
vim.keymap.set('n', '<leader>mm', function()
  local dbee = require 'dbee'
  -- Execute a simple command to connect without listing dbs
  vim.cmd "DBeeExecute 'show collections'"
end)

require('dbee').setup {
  connections = {
    {
      type = 'mongodb',
      url = 'mongodb+srv://YaNaRion:kolia1@dev.ddwky9s.mongodb.net/dev1?appName=dev&retryWrites=true&w=majority',
      name = 'MongoDB Avanturier',
      -- CRITICAL: Prevent auto-expansion that triggers ListDatabases
      expanded = false,
    },
  },
}
