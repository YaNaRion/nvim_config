vim.pack.add {
  { src = 'https://github.com/blazkowolf/gruber-darker.nvim' },
  { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
  { src = 'https://github.com/rockyzhang24/arctic.nvim' },
  { src = 'https://github.com/rktjmp/lush.nvim' }, -- Dependency for Arctic
  { src = 'https://github.com/Mofiqul/adwaita.nvim' },
  { src = 'https://github.com/vague2k/vague.nvim' },
}

-- 1. Gruber-Darker Config
require('gruber-darker').setup {
  -- bold = false,
  -- italic = { strings = false },
}

-- 2. Rose-Pine Config
require('rose-pine').setup {
  styles = {
    bold = true,
    italic = true,
    transparency = true,
  },
}

-- 3. Adwaita Config
vim.g.adwaita_transparent = true

-- 4. Vague Config
require('vague').setup {
  transparent = false,
  style = {
    boolean = 'bold',
    comments = 'italic',
    keyword_return = 'italic',
    strings = 'italic',
    builtin_constants = 'bold',
    builtin_types = 'bold',
    headings = 'bold',
  },
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

local color = 'vague'
-- local color = 'gruber-darker'
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

ColorMyPencils()
