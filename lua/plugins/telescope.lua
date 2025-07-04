return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>pf',
      function()
        require('telescope.builtin').find_files()
      end,
      desc = 'Find Files',
    },

    {
      '<C-p>',
      function()
        require('telescope.builtin').git_files()
      end,
      desc = 'Find Git Files',
    },

    {
      '<leader>ps',
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = 'Live Grep',
    },
  },
}
