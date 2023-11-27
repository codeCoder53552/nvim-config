-- eat warnings
local vim = vim

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

local function disable_diagnostics()
    vim.diagnostic.config({
      virtual_text = false, -- Turn off inline diagnostics
    })
end

local function enable_diagnostics()
    vim.diagnostic.config({
      virtual_text = true, -- Turn off inline diagnostics
    })
end

dap.listeners.after.event_initialized["dapui_config"] = function ()
    dapui.open()
    disable_diagnostics()
end
dap.listeners.after.event_terminated["dapui_config"] = function ()
    dapui.close()
    enable_diagnostics()
end
dap.listeners.after.event_exited["dapui_config"] = function ()
    dapui.close()
    disable_diagnostics()
end

-- vim.keymap.set("n", "<Leader>db", ":DapToggleBreakpoint<CR>")
-- vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
-- vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
-- vim.keymap.set("n", "<Leader>dc", ":Dapuj<CR>")

vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<Leader>dc", dap.continue)
vim.keymap.set("n", "<Leader>do", dap.step_over)
vim.keymap.set("n", "<Leader>di", dap.step_into)
vim.keymap.set("n", "<Leader>dx", dap.terminate)

local telescope = require("telescope")
telescope.load_extension("dap")
vim.keymap.set("n", "<Leader>df", telescope.extensions.dap.frames)

-- inline virtual variable values
require("nvim-dap-virtual-text").setup{
    enabled = true,
}

-- example configs for additional languages
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

dap.adapters.python = function(cb, config)

    if config.request == "attatch" then
        local port = (config.connect or config).port
        local host = (config.connect or config).host or "127.0.0.1"
        cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attatch` configuration"),
            host = howt,
            options = {
                source_filetype = "python",
            },
        })
    else
        local command = nil
        if os.getenv("VIRTUAL_ENV") then
            command = os.getenv("VIRTUAL_ENV") .. "/bin/python"
        else
            command = "python3"
        end
        cb({
            type = "executable",
            command = command,
            args = { '-m', 'debugpy.adapter' },
            options = {
                source_filetype = 'python',
            },
        })
    end
end

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    console = "integratedTerminal";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python3'
      end
    end;
  },
}


