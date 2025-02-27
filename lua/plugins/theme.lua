local color = 'adwaita'
function ColorMyPencils(colorFunc)
  if colorFunc then
    colorFunc = tostring(colorFunc)
    vim.cmd.colorscheme(colorFunc)
  else
    vim.cmd.colorscheme(color)
  end

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

return {
  {
    'olivercederborg/poimandres.nvim',
    priority = 1000,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme(color)
      -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'FrenzyExists/aquarium-vim',
    priority = 1000,
  },
  {
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = 'hard'
      vim.g.everforest_ui_contrast = 'high'
    end,
  },
  {
    'rose-pine/neovim',
    priority = 1000,
  },
  {
    'ficcdaf/ashen.nvim',
    priority = 1000,
  },
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
  },
  {
    'rockyzhang24/arctic.nvim',
    branch = 'v2',
    dependencies = { 'rktjmp/lush.nvim' },
  },
  {
    'navarasu/onedark.nvim',
    style = 'Darker',
  },

  {
    'Mofiqul/adwaita.nvim',
    lazy = false,
    priority = 1000,
  },
}
