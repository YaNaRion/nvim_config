require 'basic'
require 'plugins'



-- TEST FOR NVIM 0.12
--
--
--
-- require('vim._core.ui2').enable()
-- vim.diagnostic.status()
-- vim.lsp.status()

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- vim.opt.termguicolors = true
--

-- -- [[ Install `lazy.nvim` plugin manager ]]
-- local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
--   local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
--   if vim.v.shell_error ~= 0 then
--     error('Error cloning lazy.nvim:\n' .. out)
--   end
-- end ---@diagnostic disable-next-line: undefined-field
-- vim.opt.rtp:prepend(lazypath)
--
--
-- vim.pack.add {
--   'https://github.com/tpope/vim-sleuth',
--   'https://github.com/lewis6991/gitsigns.nvim',
-- }

-- [[ Configure and install plugins ]]
-- require('lazy').setup({
--   'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
--   { -- Adds git related signs to the gutter, as well as utilities for managing changes
--     'lewis6991/gitsigns.nvim',
--     opts = {
--       signs = {
--         add = { text = '󱌃' },
--         change = { text = '' },
--         delete = { text = '󰳭' },
--         topdelete = { text = '󰳭' },
--         changedelete = { text = '' },
--       },
--
--       current_line_blame = true,
--       current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
--       current_line_blame_opts = {
--         delay = 1000,
--         ignore_whitespace = false,
--         virt_text = true,
--         virt_text_priority = 100,
--         virt_text_pos = 'eol',
--       },
--     },
--   },
--
--   require 'kickstart.plugins.debug',
--   -- require 'kickstart.plugins.indent_line', si active probleme au lancement de nvim
--   require 'kickstart.plugins.lint',
--   -- require 'kickstart.plugins.autopairs',
--   -- require 'kickstart.plugins.neo-tree',
--   require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
--
--   { import = 'plugins' },
-- }, {
-- ui = {
--   icons = vim.g.have_nerd_font and {} or {
--     cmd = '⌘',
--     config = '🛠',
--     event = '📅',
--     ft = '📂',
--     init = '⚙',
--     keys = '🗝',
--     plugin = '🔌',
--     runtime = '💻',
--     require = '🌙',
--     source = '📄',
--     start = '🚀',
--     task = '📌',
--     lazy = '💤 ',
--   },
-- },
-- })

-- ColorMyPencils()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2
--
