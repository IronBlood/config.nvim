return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    version = "2.*",
    dependencies = {
      {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        version = "1.x",
        ft = "lua",
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      -- Automatically install LSPs to stdpath for neovim
      { "mason-org/mason.nvim", version = "2.x", opts = {} },
      { "mason-org/mason-lspconfig.nvim", version = "2.x" },
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", opts = {} },
      -- Renders diagnostics using virtual lines
      { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", version = "3.x" },
    },
    config = function()
      require("config.lsp").setup()
    end,
  },
  {
    "b0o/SchemaStore.nvim",
  },
}
