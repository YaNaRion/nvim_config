vim.pack.add {
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
}

local telescope = require 'telescope'
local builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'

telescope.setup {
  extensions = {
    ['ui-select'] = { themes.get_dropdown() },
  },
}

-- Enable extensions
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')

-- Global Keymaps
local map = vim.keymap.set
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<C-p>', builtin.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
map({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
map('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
map('n', '<C-o>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Custom Search Functions
map('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

map('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

map('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }

    map('n', 'grr', builtin.lsp_references, { buffer = event.buf, desc = 'LSP: [G]oto [R]eferences' })
    map('n', 'gri', builtin.lsp_implementations, { buffer = event.buf, desc = 'LSP: [G]oto [I]mplementation' })
    map('n', 'grd', builtin.lsp_definitions, { buffer = event.buf, desc = 'LSP: [G]oto [D]efinition' })
    map('n', 'grt', builtin.lsp_type_definitions, { buffer = event.buf, desc = 'LSP: [G]oto [T]ype Definition' })
    map('n', 'gO', builtin.lsp_document_symbols, { buffer = event.buf, desc = 'LSP: Document Symbols' })
    map('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = event.buf, desc = 'LSP: Workspace Symbols' })
  end,
})
