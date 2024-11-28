local color = 'rose-pine'
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
    'rose-pine/neovim',
    priority = 1000,
  },
}
