local dap, dapui = require("dap"), require("dapui")
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', {text='ﭦ', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='💀', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='', numhl=''})
