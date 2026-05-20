local parsed = require("utils.dotenv").parse_plugin_env()
local WHISPER_AUTO = parsed.WHISPER_AUTO or ""
local WHISPER_EN = parsed.WHISPER_EN or ""

return {
  "IronBlood/whisper.nvim",
  config = function()
    local whisper = require("whisper")

    whisper.setup({
      endpoints = {
        auto = WHISPER_AUTO,
        en = WHISPER_EN,
      },
    })

    vim.keymap.set("i", "<F8>", function()
      whisper.toggle("en")
    end, { desc = "Whisper toggle recording (Enlish auto-translated)" })
    vim.keymap.set("i", "<F9>", function()
      whisper.toggle("auto")
    end, { desc = "Whisper toggle recording (native language)" })
    vim.keymap.set("n", "<leader>ww", function()
      whisper.toggle("en")
    end, { desc = "Whisper toggle recording (English auto-translated)" })
  end,
}
