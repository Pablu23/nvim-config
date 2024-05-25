return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "rust_analyzer",
          "html",
          "zls",
          "biome",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.zls.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.biome.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {})
    end,
  },
}
