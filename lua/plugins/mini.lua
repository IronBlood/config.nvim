return {
  "nvim-mini/mini.nvim",
  enabled = false,
  config = function()
    -- Try:
    -- - ga=
    -- - gajc
    require("mini.align").setup()
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()
  end,
}
