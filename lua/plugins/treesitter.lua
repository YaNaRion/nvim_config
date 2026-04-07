vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
}

local configs = require('nvim-treesitter')

configs.setup {
  -- A list of parser names, or "all" 
  ensure_installed = {
    'bash',
    'c',
    'diff',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
    'rust', -- Added since you're working on EasyGestion
    'ron',
    'go',
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
    -- If you are on Arch and experience slow-down with large files, 
    -- you can set this to a function to disable for big files
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },
}
vim.opt.termguicolors = true
-- Optional: Folding configuration
-- This uses Treesitter to handle code folding (za, zM, zR)
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldenable = false -- Don't fold everything by default when opening
