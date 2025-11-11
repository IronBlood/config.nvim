return {
  "nvim-mini/mini.nvim",
  config = function()
    require("mini.ai").setup()
    -- Try:
    -- - ga=
    -- - gajc
    require("mini.align").setup()
    -- []Bb buffer
    -- []Cc comment
    -- []Xx conflict
    -- []Dd diagnostic
    -- []Ff file
    -- []Ii indent
    -- []Oo old files WARN BE CAREFUL
    -- []Qq quick fix
    -- []Uu undo / redo
    -- []Ww window in current lab
    require("mini.bracketed").setup()
    -- alt/meta + hjkl
    require("mini.move").setup()
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()
    -- lua MiniTrailspace.trim()
    -- lua MiniTrailspace.trim_last_lines()
    require("mini.trailspace").setup()
  end,
}
