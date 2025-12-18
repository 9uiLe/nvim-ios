-- lua/config/env.lua
-- 環境変数の読み込みと管理

local M = {}

-- .env ファイルのパス
local env_file = vim.fn.stdpath("config") .. "/.env"

-- 環境変数を格納するテーブル
M.vars = {}

-- デフォルト値
local defaults = {
  IOS_SDK_PATH = nil, -- 自動検出を試みる
  IOS_TARGET = "arm64-apple-ios18.0-simulator",
  LEADER_KEY = " ",
  COLORSCHEME = "tokyonight",
}

-- .env ファイルを読み込む
local function load_env_file()
  local file = io.open(env_file, "r")
  if not file then
    return false
  end

  for line in file:lines() do
    -- コメントと空行をスキップ
    if not line:match("^%s*#") and not line:match("^%s*$") then
      -- KEY=VALUE の形式をパース
      local key, value = line:match("^%s*([%w_]+)%s*=%s*(.+)%s*$")
      if key and value then
        -- クォートを削除
        value = value:gsub('^"', ""):gsub('"$', "")
        value = value:gsub("^'", ""):gsub("'$", "")
        M.vars[key] = value
      end
    end
  end

  file:close()
  return true
end

-- iOS SDK パスを自動検出
local function auto_detect_sdk_path()
  local handle = io.popen("xcrun --sdk iphonesimulator --show-sdk-path 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result and result ~= "" then
      return result:gsub("%s+$", "") -- 末尾の改行を削除
    end
  end
  return nil
end

-- 環境変数を取得（デフォルト値あり）
function M.get(key, default)
  return M.vars[key] or default or defaults[key]
end

-- 初期化
function M.setup()
  -- .env ファイルを読み込み
  local loaded = load_env_file()

  if not loaded then
    vim.notify(
      "Warning: .env file not found. Using default values.\nRun setup script to create .env file.",
      vim.log.levels.WARN
    )
  end

  -- デフォルト値を設定
  for key, value in pairs(defaults) do
    if not M.vars[key] then
      M.vars[key] = value
    end
  end

  -- iOS SDK パスの自動検出
  if not M.vars.IOS_SDK_PATH then
    local sdk_path = auto_detect_sdk_path()
    if sdk_path then
      M.vars.IOS_SDK_PATH = sdk_path
    else
      vim.notify(
        "Warning: Could not auto-detect iOS SDK path. LSP may not work correctly.",
        vim.log.levels.WARN
      )
    end
  end

  return M
end

return M
