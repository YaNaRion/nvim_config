-- 1. Package Declarations
vim.pack.add {
  { src = 'https://github.com/NvChad/nvterm' },
  { src = 'https://github.com/numToStr/Comment.nvim' },
  { src = 'https://github.com/ThePrimeagen/vim-be-good' },
}

-- 2. Helper Function for Shell
local function shell_type()
  local os_name = vim.loop.os_uname().sysname
  if os_name == 'Windows_NT' then
    return 'powershell'
  else
    return vim.o.shell
  end
end

-- 3. Load Packages
vim.cmd('packadd nvterm')
vim.cmd('packadd Comment.nvim')
vim.cmd('packadd vim-be-good')

-- 4. NvTerm Configuration
local nvterm = require('nvterm')
nvterm.setup({
  terminals = {
    shell = shell_type(),
    type_opts = {
      float = {
        relative = 'editor',
        row = 0.3, col = 0.25, width = 0.5, height = 0.4,
        border = 'single',
      },
      horizontal = { location = 'rightbelow', split_ratio = 0.3 },
      vertical = { location = 'rightbelow', split_ratio = 0.5 },
    },
  },
  behavior = {
    autoclose_on_quit = { enabled = false, confirm = true },
    close_on_exit = true,
    auto_insert = true,
  },
})

-- NvTerm Mappings
local terminal = require('nvterm.terminal')
local toggle_modes = { 'n', 't' }
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<C-l>', function() 
  local ft_cmds = { python = 'python3 ' .. vim.fn.expand('%') }
  terminal.send(ft_cmds[vim.bo.filetype])
end, opts)

vim.keymap.set(toggle_modes, '<A-h>', function() terminal.toggle('horizontal') end, opts)
vim.keymap.set(toggle_modes, '<A-v>', function() terminal.toggle('vertical') end, opts)
vim.keymap.set(toggle_modes, '<A-i>', function() terminal.toggle('float') end, opts)

-- 5. Comment.nvim Configuration
require('Comment').setup({}) -- Basic setup is required for the API to work
local comment_api = require('Comment.api')

-- Normal mode toggle
vim.keymap.set('n', '<C-/>', function()
  comment_api.toggle.linewise.current()
end, { desc = 'Toggle comment' })

-- Visual mode toggle
vim.keymap.set('v', '<C-/>', function()
  -- Using the Lua API directly is cleaner than the <ESC><CMD> string
  local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'nx', false)
  comment_api.toggle.linewise(vim.fn.visualmode())
end, { desc = 'Toggle comment visual' })
