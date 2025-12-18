-- lua/plugins/dap.lua
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap_status_ok, dap = pcall(require, "dap")
      if not dap_status_ok then
        return
      end

      local dapui_status_ok, dapui = pcall(require, "dapui")
      if not dapui_status_ok then
        return
      end

      local virtual_text_status_ok, virtual_text = pcall(require, "nvim-dap-virtual-text")
      if not virtual_text_status_ok then
        return
      end

      -- DAP UI のセットアップ
      dapui.setup()

      -- Virtual text のセットアップ
      virtual_text.setup()

      -- デバッグセッション開始時に UI を自動で開く
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- デバッグセッション終了時に UI を自動で閉じる
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- xcodebuild.nvim と連携するための設定
      -- xcodebuild.nvim が自動的に DAP を設定してくれます

      -- キーマッピング
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
      vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle DAP UI" })
    end,
  },
}
