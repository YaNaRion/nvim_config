-- 1. Package Declarations
vim.pack.add {
  { src = 'https://github.com/folke/lazydev.nvim' },
  { src = 'https://github.com/Bilal2453/luvit-meta' },
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/williamboman/mason.nvim' },
  { src = 'https://github.com/williamboman/mason-lspconfig.nvim' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/L3MON4D3/LuaSnip' },
  { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
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
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

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

-- 8. Completion (nvim-cmp)
-- 8. Completion (nvim-cmp)
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- menuone: shows menu even if there is only one suggestion
  -- noinsert: prevents the menu from automatically inserting text until you select it
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-Space>'] = cmp.mapping.complete {},

    -- Confirm with Enter:
    -- If the menu is visible, confirm the selection.
    -- If not, behave like a normal Enter key (new line).
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- Tab navigation (Next item or jump forward in snippet)
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Shift-Tab navigation (Previous item or jump backward in snippet)
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'lazydev', group_index = 0 },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}
