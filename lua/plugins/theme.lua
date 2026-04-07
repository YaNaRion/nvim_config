-- local color = 'vague'
local color = 'gruber-darker'
-- local color = 'zenbones'
function ColorMyPencils(colorFunc)
  if colorFunc then
    colorFunc = tostring(colorFunc)
    vim.cmd.colorscheme(colorFunc)
  else
    vim.cmd.colorscheme(color)
  end

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'VertSplit', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'TabLineFill', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none', fg = 'none' })
  vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'LineNrAbove', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'LineNrBelow', { bg = 'none' })
end

return {
  {
    'blazkowolf/gruber-darker.nvim',
    opts = {
      bold = false,
      italic = {
        strings = false,
      },
    },
  },
  {
    'rose-pine/neovim',
    styles = {
      bold = true,
      italic = true,
      transparency = true,
    },
    priority = 1000,
  },
  {
    'rockyzhang24/arctic.nvim',
    branch = 'v2',
    dependencies = { 'rktjmp/lush.nvim' },
  },

  {
    'Mofiqul/adwaita.nvim',
    transparent = true,
    lazy = false,
    priority = 1000,
  },
  -- Lazy
  {
    'vague2k/vague.nvim',
    config = function()
      require('vague').setup {
        transparent = false, -- don't set background
        style = {
          -- "none" is the same thing as default. But "italic" and "bold" are also valid options
          boolean = 'bold',
          number = 'none',
          float = 'none',
          error = 'bold',
          comments = 'italic',
          conditionals = 'none',
          functions = 'none',
          headings = 'bold',
          operators = 'none',
          strings = 'italic',
          variables = 'none',

          -- keywords
          keywords = 'none',
          keyword_return = 'italic',
          keywords_loop = 'none',
          keywords_label = 'none',
          keywords_exception = 'none',

          -- builtin
          builtin_constants = 'bold',
          builtin_functions = 'none',
          builtin_types = 'bold',
          builtin_variables = 'none',
        },
        -- plugin styles where applicable
        -- make an issue/pr if you'd like to see more styling options!
        plugins = {
          cmp = {
            match = 'bold',
            match_fuzzy = 'bold',
          },
          dashboard = {
            footer = 'italic',
          },
          lsp = {
            diagnostic_error = 'none',
            diagnostic_hint = 'none',
            diagnostic_info = 'italic',
            diagnostic_warn = 'bold',
          },
          neotest = {
            focused = 'bold',
            adapter_name = 'bold',
          },
          telescope = {
            match = 'bold',
          },
        },

        -- Override colors
        colors = {
          bg = '#141415',
          fg = '#cdcdcd',
          floatBorder = '#878787',
          line = '#252530',
          comment = '#606079',
          builtin = '#b4d4cf',
          func = '#c48282',
          string = '#e8b589',
          number = '#e0a363',
          property = '#c3c3d5',
          constant = '#aeaed1',
          parameter = '#bb9dbd',
          visual = '#333738',
          error = '#df6882',
          warning = '#f3be7c',
          hint = '#7e98e8',
          operator = '#90a0b5',
          keyword = '#6e94b2',
          type = '#9bb4bc',
          search = '#405065',
          plus = '#8cb66d',
          delta = '#f3be7c',
        },
      }
    end,
  },
}
