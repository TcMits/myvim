local dap = require("dap")

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })


local get_python_path = function()
  local venv_path = os.getenv('VIRTUAL_ENV')
  if venv_path then
    return venv_path .. '/bin/python'
  end

  venv_path = os.getenv("CONDA_PREFIX")
  if venv_path then
    return venv_path .. '/bin/python'
  end

  return nil
end


dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = get_python_path,
  },
}

dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug Package",
    request = "launch",
    program = "${fileDirname}",
  },
}

dap.adapters.python = function(cb, config)
  cb({
    type = 'executable',
    command = get_python_path(),
    args = { '-m', 'debugpy.adapter' },
    options = {
      source_filetype = 'python',
    }
  })
end

dap.adapters.go = {
  type = "server",
  port = 2345,
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:" .. 2345 },
  },
  options = {
    initialize_timeout_sec = 20,
  },
}


local dapui = require("dapui")

dapui.setup({
  sidebar = {
    elements = {
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
    },
    size = 40,
    position = "right", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = {},
  },
})


dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


local dap_install = require("dap-install")

dap_install.setup({
  installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})

dap_install.config("python", {})
dap_install.config("go", {})
