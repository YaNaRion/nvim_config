local color = 'rose-pine'
function ColorMyPencils(colorFunc)
  colorFunc = colorFunc or color
  vim.cmd.colorscheme(colorFunc)
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

return {
  {
    'olivercederborg/poimandres.nvim',
    priority = 1000,
  },
  {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme(color)
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
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
}
