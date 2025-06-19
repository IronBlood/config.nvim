local dap = require("dap")
local dapui = require("dapui")
local set = vim.keymap.set

dapui.setup()

local js_debug_adapter = vim.fn.exepath("js-debug-adapter")

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = js_debug_adapter,
    args = {
      "${port}",
    },
  },
}

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch File",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

-- Eval var under cursor
set("n", "<leader>d?", function()
  ---@diagnostic disable-next-line
  dapui.eval(nil, { enter = true })
end, { desc = "Show Current Value" })

set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
set("n", "<leader>dc", dap.continue, { desc = "DAP Continue / Launch" })
set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle DAP REPL" })

set("n", "<F1>", dap.continue)
set("n", "<F2>", dap.step_into)
set("n", "<F3>", dap.step_over)
set("n", "<F4>", dap.step_out)
set("n", "<F5>", dap.step_back)
set("n", "<F13>", dap.restart)

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
