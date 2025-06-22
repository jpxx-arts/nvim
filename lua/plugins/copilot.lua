return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  -- event = "InsertEnter",
  keys = {
    { "<leader>ce", "<cmd>Copilot enable<CR>", desc = "Enable Copilot" },
    { "<leader>cd", "<cmd>Copilot disable<CR>", desc = "Disable Copilot" },
    { "<leader>cs", "<cmd>Copilot status<CR>", desc = "Copilot Status" },
  },
  config = function()
    local home = vim.fn.expand("~")
    local has_auth = vim.fn.filereadable(home .. "/.config/github-copilot/apps.json") == 1

    if not has_auth then
      vim.notify("You must authenticate. Run :Copilot auth", vim.log.levels.WARN)
      return
    end

    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-[>",
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-e>",
        },
      },
      panel = { enabled = true },
    })
  end,
}

