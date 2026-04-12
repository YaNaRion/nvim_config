vim.pack.add {
  {
    src = 'https://github.com/ej-shafran/compile-mode.nvim',
    version = 'v5.14.0',
  },
  {
    src = 'https://github.com/nvim-lua/plenary.nvim',
  },
  {
    src = 'https://github.com/m00qek/baleia.nvim',
    tag = 'v1.3.0',
  },
}

vim.g.compile_mode = {
  -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
  -- set this to fix tab completion in command mode:
  input_word_completion = true,

  -- to add ANSI escape code support, add:
  baleia_setup = true,

  -- to make `:Compile` replace special characters (e.g. `%`) in
  -- the command (and behave more like `:!`), add:
  bang_expansion = true,
}

vim.keymap.set('n', 'ne', ':NextError <CR>')
