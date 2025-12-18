-- lua/config/keymaps.lua
-- キーマッピング設定

local keymap = vim.keymap

-- 一般的なキーマッピング

-- ノーマルモードでの保存と終了
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit All Without Saving" })

-- ウィンドウ移動
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Bottom Window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to Top Window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window" })

-- ウィンドウのリサイズ
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- バッファ移動
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- インデント調整（ビジュアルモード）
keymap.set("v", "<", "<gv", { desc = "Decrease Indent" })
keymap.set("v", ">", ">gv", { desc = "Increase Indent" })

-- 行移動（ビジュアルモード）
keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move Line Down" })
keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move Line Up" })

-- 検索ハイライトをクリア
keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Search Highlight" })

-- 行の結合時にカーソルを移動させない
keymap.set("n", "J", "mzJ`z", { desc = "Join Lines" })

-- スクロール時に画面中央を保つ
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })
keymap.set("n", "n", "nzzzv", { desc = "Next Search Result" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous Search Result" })

-- ペースト後に選択を保持
keymap.set("x", "p", [["_dP]], { desc = "Paste Without Yanking" })

-- ターミナルモード
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
