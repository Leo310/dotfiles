local M = {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            config = function()
                require("dapui").setup()
            end,
        },
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
    },
}
function M.init()
    -- Keymaps
    local dap, dapui = require("dap"), require("dapui")
    vim.keymap.set("n", "<F5>", function()
        dap.continue()
    end, { desc = "Debugger continue" })
    vim.keymap.set("n", "<F6>", function()
        dap.terminate()
    end, { desc = "Debugger terminate" })
    vim.keymap.set("n", "<F9>", function()
        dap.step_over()
    end, { desc = "Debugger step over" })
    vim.keymap.set("n", "<F10>", function()
        dap.step_into()
    end, { desc = "Debugger step into" })
    vim.keymap.set("n", "<F11>", function()
        dap.step_out()
    end, { desc = "Debugger step out" })

    vim.keymap.set("n", "<leader>b", function()
        dap.toggle_breakpoint()
    end, { desc = "Toggle Breakpoint" })
    -- vim.keymap.set("n", "<leader>d", function() dap.repl.toggle() end, { desc = 'Debugger REPL' })
    vim.keymap.set("n", "<leader>cl", function()
        dap.clear_breakpoints()
    end, { desc = "Clear Breakpoints" })
    vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debugger step out" })
    vim.keymap.set("n", "<leader>lp", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "Log point message" })
    vim.keymap.set("n", "<leader>dl", function()
        dap.run_last()
    end, { desc = "Debugger re-run" })
    vim.keymap.set("n", "<leader>du", function()
        dapui.toggle({})
    end, { desc = "Toggle Dapui" })
end

function M.config()
    require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
    require("dap-go").setup()

    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
    end

    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "💀", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })
end

return M
