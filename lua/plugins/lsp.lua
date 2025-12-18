-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 環境変数を取得
      local env = require("config.env")
      local sdk_path = env.get("IOS_SDK_PATH")
      local target = env.get("IOS_TARGET")

      if not sdk_path then
        vim.notify("Error: iOS SDK path not found. LSP will not work.", vim.log.levels.ERROR)
        return
      end

      -- Neovim 0.11+ の新しい API を使用
      vim.lsp.config.sourcekit = {
        cmd = {
          "sourcekit-lsp",
          "-Xswiftc",
          "-sdk",
          "-Xswiftc",
          sdk_path,
          "-Xswiftc",
          "-target",
          "-Xswiftc",
          target,
        },
        filetypes = { "swift", "objc", "objcpp" },
        root_markers = { "Package.swift", ".git" },
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      }

      -- Swift/Objective-C ファイルを開いた時に LSP を自動起動
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "swift", "objc", "objcpp" },
        callback = function()
          vim.lsp.enable("sourcekit")
        end,
      })

      -- LSP がアタッチされたときのキーマッピング
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf, silent = true }

          -- ホバー表示
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

          -- 定義ジャンプ
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

          -- 参照を表示
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

          -- リネーム
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

          -- コードアクション
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

          -- 診断を表示
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

          -- 次の診断へ移動
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

          -- 前の診断へ移動
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        end,
      })
    end,
  },
}