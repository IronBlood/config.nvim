return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local TodoComment = require("todo-comments")
    local set = vim.keymap.set
    set("n", "]t", TodoComment.jump_next, { desc = "Next todo comment" })
    set("n", "[t", TodoComment.jump_prev, { desc = "Previous todo comment" })
  end,
  opts = {
    signs = true,
    merge_keywords = false,
    highlight = {
      multiline = false,
    },
  },
}
