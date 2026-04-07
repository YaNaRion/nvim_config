-- 1. Package Declarations
vim.pack.add {
  { src = 'https://github.com/tpope/vim-sleuth' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/tpope/vim-fugitive' },
}

-- 2. Fugitive Global Map
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

-- 3. Gitsigns On Attach Function
local on_attach_func = function(bufnr) -- Changed to a standard variable assignment
  local gitsigns = require 'gitsigns'

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal { ']c', bang = true }
    else
      gitsigns.nav_hunk 'next'
    end
  end, { desc = 'Jump to next git [c]hange' })

  map('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal { '[c', bang = true }
    else
      gitsigns.nav_hunk 'prev'
    end
  end, { desc = 'Jump to previous git [c]hange' })

  -- Actions (Visual)
  map('v', '<leader>hs', function()
    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'stage git hunk' })
  map('v', '<leader>hr', function()
    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'reset git hunk' })

  -- Actions (Normal)
  map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
  map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
  map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
  map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
  map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
  map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
  map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
  map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
  map('n', '<leader>hD', function()
    gitsigns.diffthis '@'
  end, { desc = 'git [D]iff against last commit' })

  -- Toggles
  map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
  map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
end

-- 4. Gitsigns Setup
require('gitsigns').setup {
  -- Note: Removed the "opts = {}" wrapper as gitsigns expects keys at top level
  signs = {
    add = { text = '󱌃' },
    change = { text = '' },
    delete = { text = '󰳭' },
    topdelete = { text = '󰳭' },
    changedelete = { text = '' },
  },

  current_line_blame = true,
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  current_line_blame_opts = {
    delay = 1000,
    ignore_whitespace = false,
    virt_text = true,
    virt_text_priority = 100,
    virt_text_pos = 'eol',
  },

  -- Pass the function reference, NOT the result of calling it
  on_attach = on_attach_func,
}
