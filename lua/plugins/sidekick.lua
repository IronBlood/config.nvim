local parsed = require("utils.dotenv").parse_plugin_env()
local HTTPS_PROXY = parsed.HTTPS_PROXY or ""

local tools = {}

if #HTTPS_PROXY > 0 then
  for _, name in ipairs({ "codex", "copilot", "gemini" }) do
    tools[name] = {
      env = {
        http_proxy = HTTPS_PROXY,
        HTTP_PROXY = HTTPS_PROXY,
        https_proxy = HTTPS_PROXY,
        HTTPS_PROXY = HTTPS_PROXY,
      },
    }
  end
end

return {
  "folke/sidekick.nvim",
  version = "1.*",
  opts = {
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
      tools = tools,
    },
    -- disable Next Edit Suggestion
    nex = {
      enabled = false,
    },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select()
      end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<c-.>",
      function()
        require("sidekick.cli").focus()
      end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Switch Focus",
    },
  },
}
