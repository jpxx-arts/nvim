return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'Bekaboo/dropbar.nvim',
  },
  opts = {
    theme = 'base16',
    sections = {
      lualine_c = {
        {
          function()
            return require('dropbar.api').get_dropbar_str()
          end,
          color = { fg = '#a6e3a1' },
          cond = function()
            return vim.fn.bufname() ~= ''
          end,
        },
      },
    },
  },
}

