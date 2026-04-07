-- debug.lua
-- Using native vim.pack.add with 100% original feature/hotkey parity

-- 1. Package Declarations
vim.pack.add {
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/rcarriga/nvim-dap-ui' },
  { src = 'https://github.com/nvim-neotest/nvim-nio' },
  { src = 'https://github.com/williamboman/mason.nvim' },
  { src = 'https://github.com/jay-babu/mason-nvim-dap.nvim' },
  { src = 'https://github.com/leoluz/nvim-dap-go' },
}

-- 2. Configuration & UI Setup
local dap = require 'dap'
local dapui = require 'dapui'

require('mason-nvim-dap').setup {
  automatic_installation = true,
  handlers = {},
  ensure_installed = {
    'delve',
    'codelldb',
  },
}

dapui.setup {
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}

-- 3. Original Visuals (Icons & Highlights)
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })

local breakpoint_icons = vim.g.have_nerd_font
    and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
  or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }

for type, icon in pairs(breakpoint_icons) do
  local tp = 'Dap' .. type
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

-- 4. Automation Hooks
dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- 5. Original Hotkeys (Mapped exactly as in your source)
vim.keymap.set('n', '<F9>', dap.continue, { desc = 'Debug: Continue' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<C-b>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<F-&>', dap.terminate, { desc = 'Debug: Terminate Session' })
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })
vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

-- 6. Language Specifics (Go, C, C++)
require('dap-go').setup {
  delve = {
    detached = vim.fn.has 'win32' == 0,
  },
}

dap.adapters.gdb = {
  type = 'executable',
  command = 'gdb',
  args = { '-i', 'dap' },
}

local c_config = {
  {
    name = 'Launch',
    type = 'gdb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
}

dap.configurations.c = c_config
dap.configurations.cpp = c_config
