return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter-intro`

      local configs = require 'nvim-treesitter.configs'

      configs.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
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
        },

        -- Autoinstall languages that are not installed. Defaults to false (but useful!)
        auto_install = true,

        highlight = {
          enable = true, -- Enable Treesitter syntax highlighting

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true, -- Enable Treesitter-based indentation (=)
        },

        -- If you want to enable folding, uncomment the lines below in your
        -- init.lua or a separate autocmd. Treesitter doesn't manage folds
        -- inside the .setup() call directly.
      }

      -- Optional: Set up folding using Treesitter
      -- vim.opt.foldmethod = "expr"
      -- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      -- vim.opt.foldenable = false -- Prevent folds from closing by default when opening a file
    end,
  },
}
