return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "windwp/nvim-autopairs",
    },
    config = function()
      -- 🪟 SignColumn sempre visível
      vim.opt.signcolumn = "yes"

      -- 🧠 Autopairs
      require("nvim-autopairs").setup()

      -- 🧰 Mason UI
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- 🔌 Mason-LSPConfig
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "bashls", "jdtls" },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
        },
      })

      -- ⚙️ Capabilities do nvim-cmp
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- 📦 Configuração dos LSPs
      local lspconfig = require("lspconfig")
      local servers = { "lua_ls", "bashls", "gleam", "ocamllsp" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({ capabilities = capabilities })
      end

      -- ⚡ Keymaps com autocmd
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
          vim.keymap.set({ "n", "x" }, "<F3>", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
        end,
      })
    end,

    keys = {
      { "<leader>m", "<cmd>Mason<CR>", desc = "Opens Mason" }
    },
  },
}
