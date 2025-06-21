return {
  "ThePrimeagen/harpoon",
  opts = {},

  keys = {
    { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon: add file" },
    { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: show menu" },

    { "<A-a>", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon: go to file 1" },
    { "<A-s>", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon: go to file 2" },
    { "<A-d>", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon: go to file 3" },
    { "<A-f>", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon: go to file 4" },
  },
}

