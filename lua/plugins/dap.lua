local dap = require('dap')
local dapui = require('dapui')
local utils = require('utils')

require('dap-python').setup(utils.find_python())
require('dap-go').setup()

require("dapui").setup()

vim.cmd [[ command! DapOpen lua require("dapui").open() ]]
vim.cmd [[ command! DapClose lua require("dapui").close()]]
vim.cmd [[ command! DapToggle lua require("dapui").toggle()]]

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
