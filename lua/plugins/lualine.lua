return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    theme = 'base16',
    sections = {
      lualine_c = {
        {
          'filename',
          file_status = true,
          path = 1 -- relative path display
        }
      }
    }
  }
}
