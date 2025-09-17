-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
function ShellType()
  local os_name = vim.loop.os_uname().sysname

  if os_name == 'Linux' then
    return vim.o.shell
  elseif os_name == 'Darwin' then -- macOS
    return vim.o.shell
  elseif os_name == 'Windows_NT' then -- Windows
    return 'powershell'
  else
    print('Running on an unknown OS: ' .. os_name)
  end
end

return {
  {
    'NvChad/nvterm',
    config = function()
      require('nvterm').setup {
        terminals = {
          shell = ShellType(),
          list = {},
          type_opts = {
            float = {
              relative = 'editor',
              row = 0.3,
              col = 0.25,
              width = 0.5,
              height = 0.4,
              border = 'single',
            },
            horizontal = { location = 'rightbelow', split_ratio = 0.3 },

            vertical = { location = 'rightbelow', split_ratio = 0.5 },
          },
        },
        behavior = {
          autoclose_on_quit = {
            enabled = false,
            confirm = true,
          },
          close_on_exit = true,
          auto_insert = true,
        },
      }
      local terminal = require 'nvterm.terminal'

      local ft_cmds = {
        python = 'python3 ' .. vim.fn.expand '%',
      }
      local toggle_modes = { 'n', 't' }
      local mappings = {
        {
          'n',
          '<C-l>',
          function()
            terminal.send(ft_cmds[vim.bo.filetype])
          end,
        },
        {
          toggle_modes,
          '<A-h>',
          function()
            terminal.toggle 'horizontal'
          end,
        },
        {
          toggle_modes,
          '<A-v>',
          function()
            terminal.toggle 'vertical'
          end,
        },
        {
          toggle_modes,
          '<A-i>',
          function()
            terminal.toggle 'float'
          end,
        },
      }
      local opts = { noremap = true, silent = true }
      for _, mapping in ipairs(mappings) do
        vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
      end
    end,
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      vim.keymap.set('n', '<C-/>', function()
        require('Comment.api').toggle.linewise.current()
      end)

      vim.keymap.set('v', '<C-/>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
    end,
  },
  {
    'ThePrimeagen/vim-be-good',
  },
}
