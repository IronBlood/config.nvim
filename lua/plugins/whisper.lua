return {
  "IronBlood/whisper.nvim",
  config = function()
    local whisper = require("whisper")

    whisper.setup({
      endpoint = "http://127.0.0.1:8081/inference",
    })

    vim.keymap.set("i", "<F8>", function()
      whisper.toggle()
    end, { desc = "Whisper toggle recording" })
    vim.keymap.set("n", "<leader>ww", function()
      whisper.toggle()
    end, { desc = "Whisper toggle recording" })
  end,
}
