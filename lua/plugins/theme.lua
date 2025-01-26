local color = 'vscode'
function ColorMyPencils(colorFunc)
  if colorFunc then
    colorFunc = tostring(colorFunc)
    vim.cmd.colorscheme(colorFunc)
  else
    vim.cmd.colorscheme(color)
  end

  -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
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
    'shaunsingh/nord.nvim',
    priority = 1000,
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
}
