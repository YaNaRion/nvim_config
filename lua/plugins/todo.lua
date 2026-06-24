-- 1. Add to your package list
vim.pack.add {
  { src = 'https://github.com/echasnovski/mini.nvim' },
}

-- 2. Explicitly load the package
vim.cmd 'packadd mini.nvim'

-- 3. Configure Mini modules
-- We use a local function or direct call to initialize the features you want
local mini_ai = require 'mini.ai'
mini_ai.setup { n_lines = 500 }

-- Uncomment the lines below to enable other modules:
-- require('mini.surround').setup()
-- require('mini.git').setup()

-- Example: Statusline configuration
-- local statusline = require('mini.statusline')
-- statusline.setup({ use_icons = vim.g.have_nerd_font or true })
