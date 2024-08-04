return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "gopls",
        "rust_analyzer",
        "html",
        "zls",
        "pyright",
        "ols",
        "clangd",
        "omnisharp",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            handlers = handlers
          }
        end,
        clangd = function()
          local lspconfig = require("lspconfig")
          lspconfig.clangd.setup({
            capabilities = capabilities,
            handlers = handlers,
            init_options = {
              fallbackFlags = { '--std=c++20' }
            },
          })
        end,
      }
    })

    local lspconfig = require("lspconfig")
    lspconfig.gleam.setup({
      capabilities = capabilities,
      handlers = handlers,
      cmd = { "gleam", "lsp" },
      root_dir = lspconfig.util.root_pattern("gleam.toml", ".git"),
      filetypes = { "gleam" },
    })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {})
  end,
}
