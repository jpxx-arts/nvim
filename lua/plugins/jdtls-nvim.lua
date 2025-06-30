return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    local status_ok, jdtls = pcall(require, "jdtls")
    if not status_ok then
      vim.notify("nvim-jdtls can not be loaded", vim.log.levels.ERROR)
      return
    end

    local home = os.getenv("HOME")
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = home .. "/.local/share/nvim/jdtls-workspace/" .. project_name

    local root_dir = require("jdtls.setup").find_root({
      ".git", "mvnw", "gradlew", "pom.xml", "build.gradle",
    })

    if not root_dir then
      vim.notify("nvim-jdtls: root_dir not found", vim.log.levels.WARN)
      return
    end

    local lombok_path = home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar"
    local launcher_jar = vim.fn.glob(
      home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
    )

    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. lombok_path,
        "-jar", launcher_jar,
        "-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
        "-data", workspace_dir,
      },

      root_dir = root_dir,

      settings = {
        java = {
          signatureHelp = { enabled = true },
          extendedClientCapabilities = jdtls.extendedClientCapabilities,
          maven = { downloadSources = true },
          referencesCodeLens = { enabled = true },
          references = { includeDecompiledSources = true },
          inlayHints = {
            parameterNames = { enabled = "all" },
          },
          format = { enabled = false },
        },
      },

      init_options = {
        bundles = {},
      },
    }

    jdtls.start_or_attach(config)

    -- Refactoring
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true, desc = "" }

    map("n", "<leader>co", "<Cmd>lua require('jdtls').organize_imports()<CR>", vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
    map("n", "<leader>crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
    map("v", "<leader>crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
    map("n", "<leader>crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
    map("v", "<leader>crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
    map("v", "<leader>crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", vim.tbl_extend("force", opts, { desc = "Extract Method" }))
  end,
}

