-- 1. Package Declarations
vim.pack.add {
  { src = 'https://github.com/folke/lazydev.nvim' },
  { src = 'https://github.com/Bilal2453/luvit-meta' },
  { src = 'https://github.com/saghen/blink.lib'},
  { src = 'https://github.com/saghen/blink.cmp', tag = 'v1.10.2' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/williamboman/mason.nvim' },
  { src = 'https://github.com/williamboman/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/L3MON4D3/LuaSnip' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
}

-- 2. Basic Setup & UI
require('fidget').setup {}
require('mason').setup()

-- Config for diagnostics (floating windows)
vim.diagnostic.config {
  virtual_text = false,
  float = {
    source = 'always',
    border = 'rounded',
    focusable = false,
  },
}

-- Logic to open diagnostic popup on hover (from your Lazy config)
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, scope = 'cursor' })
  end,
})

-- 3. Mason Tool Installer (Missing in your draft)
-- This ensures non-LSP tools like stylua or clippy are present
local servers = {
  clangd = { cmd = { 'clangd', '--background-index', '--clang-tidy', '--header-insertion=never' } },
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = { command = 'clippy' },
        cargo = { allFeatures = true },
        inlayHints = { typeHints = { enable = true } }, -- Bringing back those specific Rust hints
      },
    },
  },
  lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } },
  pyright = {},
  gopls = {},
}

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, { 'stylua', 'jsonlint' })

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

-- 4. LSP & Capabilities
local capabilities = require('blink.cmp').get_lsp_capabilities()

require('lazydev').setup {
  library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } },
}

-- 5. LSP Attach (Keymaps)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    local builtin = require 'telescope.builtin'

    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
    map('gr', builtin.lsp_references, '[G]oto [R]eferences')
    map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ra', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- Hover documentation with blink.cmp-style float
    map('K', function()
      vim.lsp.buf.hover {
        border = 'rounded',
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder',
      }
    end, 'Hover documentation')

    -- Toggle Inlay Hints
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf }) -- Default to ON for Rust/etc
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- 6. Mason-LSPConfig Handlers
require('mason-lspconfig').setup {
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}

-- 7. Conform (Autoformatting)
require('conform').setup {
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    rust = { 'rustfmt' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
  },
}

require('blink.cmp').setup {
  keymap = {
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<CR>'] = { 'select_and_accept', 'fallback' },
    ['<C-l>'] = { 'snippet_forward' },
    ['<C-h>'] = { 'snippet_backward' },
    ['<C-Space>'] = { 'show', 'hide' },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
    kind_icons = {
      Text = '󰉿',
      Method = '󰆧',
      Function = '󰊕',
      Constructor = '',
      Field = '󰜢',
      Variable = '󰀫',
      Class = '󰠱',
      Interface = '',
      Module = '',
      Property = '󰜢',
      Unit = '󰑭',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '󰈇',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰏿',
      Struct = '󰙅',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '󰊄',
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  completion = {
    menu = {
      border = 'rounded',
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
      scrollbar = true,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        border = 'rounded',
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder',
      },
    },
    ghost_text = { enabled = true },
  },
  snippets = { preset = 'luasnip' },
}
