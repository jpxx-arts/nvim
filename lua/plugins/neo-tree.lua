return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Neotree" },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        position = "left",
        width = 30,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = false,
        },
      },
      git_status = {
        enable = true,
      },
      default_source = "filesystem",
    })
  end,
}
