-- Autocompletion
return {
  "saghen/blink.cmp",
  event = "VimEnter",
  version = "1.*",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = (function()
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        -- Adds a number of user-friendly snippets
        --'rafamadriz/friendly-snippets',
      },
    },
    "folke/lazydev.nvim",
  },
  config = function()
    require("config.completion")
  end,
}
