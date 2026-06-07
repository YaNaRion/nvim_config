-- ~/.config/nvim/lua/plugins/99.lua

vim.pack.add {
  {
    src = 'https://github.com/ThePrimeagen/99',
  },
}

local _99 = require '99'
local cwd = vim.uv.cwd()
local basename = vim.fs.basename(cwd) or 'default'
_99.setup {
  provider = _99.Providers.OpenCodeProvider,
  model = 'opencode/big-pickle',

  logger = {
    level = _99.DEBUG,
    path = '/tmp/' .. basename .. '.99.debug',
    print_on_error = true,
  },

  tmp_dir = './tmp',

  completion = {
    source = 'native',
    custom_rules = {
      'scratch/custom_rules/',
    },
  },
  md_files = {
    'AGENT.md',
  },
}

vim.keymap.set('v', '<leader>9v', _99.visual, { desc = '99: Visual selection' })
vim.keymap.set('n', '<leader>9x', _99.stop_all_requests, { desc = '99: Cancel' })
vim.keymap.set('n', '<leader>9s', _99.search, { desc = '99: Search' })
