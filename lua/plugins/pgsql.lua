return {
  {
    'kndndrj/nvim-dbee',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require('dbee').install()
      vim.keymap.set('n', '<leader>mm', function()
        local dbee = require 'dbee'
        -- Execute a simple command to connect without listing dbs
        vim.cmd "DBeeExecute 'show collections'"
      end)
    end,
    config = function()
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
    end,
  },
}
