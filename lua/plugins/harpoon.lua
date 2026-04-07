-- 1. Add to your package list
vim.pack.add {
  { src = 'https://github.com/ThePrimeagen/harpoon' },
  -- Harpoon usually needs plenary as a dependency
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
}

-- 2. Explicitly load the package
vim.cmd('packadd harpoon')
vim.cmd('packadd plenary.nvim')

-- 3. Configure Harpoon Keymaps
-- We use a pcall or check for the module to avoid errors if the plugin hasn't downloaded yet
local ok, _ = pcall(require, "harpoon")
if ok then
  local mark = require("harpoon.mark")
  local ui = require("harpoon.ui")

  -- Toggle file marking
  vim.keymap.set('n', '<C-8>', function() mark.toggle_file() end, { desc = 'Harpoon: Toggle Mark' })
  
  -- Toggle quick menu
  vim.keymap.set('n', '<C-7>', function() ui.toggle_quick_menu() end, { desc = 'Harpoon: Quick Menu' })

  -- Navigation Keymaps (F2 through F9)
  -- Note: We can use a simple loop here to keep your config clean
  for i = 1, 8 do
    vim.keymap.set('n', '<F' .. (i + 1) .. '>', function()
      ui.nav_file(i)
    end, { desc = 'Harpoon: Nav to file ' .. i })
  end
else
  print("Harpoon not found, run :PackInstall or check your paths")
end
