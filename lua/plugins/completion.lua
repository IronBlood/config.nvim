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
        if vim.fn.has("win32") == 1 and vim.fn.executable("mingw32-make") then
          return 'LUA_LDLIBS="-lluajit-5.1" mingw32-make install_jsregexp'
        end
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        -- Adds a number of user-friendly snippets
      },
    },
  },
  config = function()
    require("config.completion")
  end,
}
