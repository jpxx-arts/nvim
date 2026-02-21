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
      -- 🪟 SignColumn always visible
      vim.opt.signcolumn = "yes"

      -- 🧠 Autopairs setup
      require("nvim-autopairs").setup()

      -- 🧰 Mason UI setup
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- This combines the base LSP capabilities with those provided by nvim-cmp.
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- 🔌 Mason-LSPConfig setup
      -- This plugin acts as the bridge between mason (installer) and lspconfig (configurator).
      require("mason-lspconfig").setup({
        -- ✅ CONSOLIDATED: All servers are now listed here.
        -- This list ensures that Mason installs them, and the handler below configures them.
        ensure_installed = { "lua_ls", "bashls", "jdtls" },
        automatic_installation = true,
        -- This handler is called for every server in `ensure_installed`.
        -- It applies the same default configuration to each one.
        handlers = {
          function(server_name)
            if server_name == "jdtls" then
              return
            end
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
        },
      })

      -- The `mason-lspconfig` handler above now manages the setup for all servers.

      -- ⚡ Keymaps are set up once an LSP attaches to a buffer
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
      { "<leader>m", "<cmd>Mason<CR>", desc = "Opens Mason" },
    },
  },
}
