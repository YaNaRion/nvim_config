return {
  {
    'thePrimeagen/harpoon',
    config = function()
      vim.keymap.set('n', '<C-]>', function()
        require('harpoon.mark').toggle_file()
      end)

      vim.keymap.set('n', '<C-p>', function()
        require('harpoon.ui').toggle_quick_menu()
      end)

      vim.keymap.set('n', '<F1>', function()
        require('harpoon.ui').nav_file(1)
      end)
      vim.keymap.set('n', '<F2>', function()
        require('harpoon.ui').nav_file(2)
      end)
      vim.keymap.set('n', '<F3>', function()
        require('harpoon.ui').nav_file(3)
      end)
      vim.keymap.set('n', '<F4>', function()
        require('harpoon.ui').nav_file(4)
      end)
      vim.keymap.set('n', '<F5>', function()
        require('harpoon.ui').nav_file(5)
      end)
      vim.keymap.set('n', '<F6>', function()
        require('harpoon.ui').nav_file(6)
      end)

      vim.keymap.set('n', '<F7>', function()
        require('harpoon.ui').nav_file(7)
      end)

      vim.keymap.set('n', '<F8>', function()
        require('harpoon.ui').nav_file(8)
      end)
    end,
  },
}
