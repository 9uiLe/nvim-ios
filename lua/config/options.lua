-- lua/config/options.lua
-- エディタ基本設定

local opt = vim.opt

-- 行番号
opt.number = true
opt.relativenumber = true

-- タブとインデント
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- 検索
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 外観
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- 分割
opt.splitright = true
opt.splitbelow = true

-- クリップボード
opt.clipboard:append("unnamedplus")

-- バックアップ
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- アンドゥ
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undo")

-- 更新時間
opt.updatetime = 300
opt.timeoutlen = 500

-- 補完
opt.completeopt = "menu,menuone,noselect"

-- マウス
opt.mouse = "a"

-- ファイルエンコーディング
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- 折り返し
opt.wrap = false

-- リーダーキーを設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "
