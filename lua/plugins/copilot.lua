return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  keys = {
    { "<leader>ce", "<cmd>Copilot enable<CR>", desc = "Enable Copilot" },
    { "<leader>cd", "<cmd>Copilot disable<CR>", desc = "Disable Copilot" },
    { "<leader>cs", "<cmd>Copilot status<CR>", desc = "Copilot Status" },
  },
  build = ":Copilot auth",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>",
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-e>",
        },
      },
      panel = { enabled = true },
    })
  end,
}

