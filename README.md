# NeoVim iOS 開発環境

NeoVimでiOS開発を行うための設定です。Xcodeを使わずにターミナルベースで開発できます。

## クイックスタート

### 新規セットアップ

```bash
# 1. このリポジトリをクローン
git clone https://github.com/9uiLe/nvim-ios.git ~/.config/nvim

# 2. セットアップスクリプトを実行
cd ~/.config/nvim
./setup.sh

# 3. NeoVimを起動
nvim
```

### 既存環境への適用

すでに別のマシンで設定している場合：

```bash
# 1. このリポジトリをクローン
git clone https://github.com/9uiLe/nvim-ios.git ~/.config/nvim

# 2. セットアップスクリプトを実行（環境を自動検出）
cd ~/.config/nvim
./setup.sh

# 完了！
```

## 機能

### コア機能
- **SourceKit-LSP**: Swiftのコード補完、定義ジャンプ、エラー表示
- **nvim-cmp**: 高機能な自動補完
- **Treesitter**: シンタックスハイライト
- **xcodebuild.nvim**: iOS プロジェクトのビルド・実行・テスト
- **nvim-dap**: デバッグ機能

### 開発支援ツール
- **Telescope**: ファジーファインダー（ファイル検索、grep等）
- **nvim-tree**: ファイルエクスプローラー
- **Tokyo Night**: カラースキーム

## 環境変数

`.env` ファイルで環境固有の設定を管理します。セットアップスクリプトが自動生成しますが、手動で編集することもできます。

```bash
# .env の例
IOS_SDK_PATH=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk
IOS_TARGET=arm64-apple-ios18.0-simulator
LEADER_KEY=" "
COLORSCHEME=tokyonight
```

### 環境変数の取得方法

```bash
# iOS SDK パスを取得
xcrun --sdk iphonesimulator --show-sdk-path

# iOS SDK バージョンを取得
xcrun --sdk iphonesimulator --show-sdk-version
```

## 主要なキーマップ

### リーダーキー
リーダーキーは `Space` です（`.env` で変更可能）。

### ファイル操作
- `<leader>w` - ファイルを保存
- `<leader>q` - 終了
- `<leader>e` - ファイルエクスプローラーを表示/非表示
- `<leader>o` - ファイルエクスプローラーにフォーカス

### ファイル検索（Telescope）
- `<leader>ff` - ファイル検索
- `<leader>fg` - テキスト検索（grep）
- `<leader>fb` - バッファ一覧
- `<leader>fr` - 最近使ったファイル
- `<leader>fh` - ヘルプタグ検索
- `<leader>fc` - コマンド一覧

### LSP機能
- `K` - ホバー情報表示
- `gd` - 定義へジャンプ
- `gr` - 参照を表示
- `<leader>rn` - リネーム
- `<leader>ca` - コードアクション
- `<leader>d` - 診断を表示
- `]d` - 次の診断へ移動
- `[d` - 前の診断へ移動

### Xcode ビルド・実行
- `<leader>xb` - ビルド
- `<leader>xr` - ビルド & 実行
- `<leader>xt` - テスト実行
- `<leader>xT` - このテストクラスを実行
- `<leader>xs` - スキーム選択
- `<leader>xd` - デバイス選択
- `<leader>xp` - Xcodebuild アクション一覧
- `<leader>xl` - Xcodebuild ログ表示
- `<leader>xc` - コードカバレッジ切り替え
- `<leader>xC` - コードカバレッジレポート表示

### デバッグ（DAP）
- `<leader>db` - ブレークポイントの切り替え
- `<leader>dc` - デバッグ続行
- `<leader>di` - ステップイン
- `<leader>do` - ステップオーバー
- `<leader>dO` - ステップアウト
- `<leader>dr` - REPL 切り替え
- `<leader>dt` - デバッグUI切り替え

### ウィンドウ操作
- `<C-h>` - 左のウィンドウへ移動
- `<C-j>` - 下のウィンドウへ移動
- `<C-k>` - 上のウィンドウへ移動
- `<C-l>` - 右のウィンドウへ移動

### バッファ操作
- `<S-h>` - 前のバッファ
- `<S-l>` - 次のバッファ
- `<leader>bd` - バッファを削除

### 補完
- `<C-Space>` - 補完メニューを表示
- `<Tab>` - 次の補完候補
- `<S-Tab>` - 前の補完候補
- `<CR>` - 補完を確定

## 使い方

### iOS プロジェクトを開く

1. プロジェクトのルートディレクトリに移動
```bash
cd /path/to/your/ios/project
```

2. NeoVim を起動
```bash
nvim
```

3. xcodebuild.nvim でスキームとデバイスを選択
- `<leader>xs` でスキームを選択
- `<leader>xd` でデバイスを選択

4. ビルド & 実行
- `<leader>xr` でビルドして実行

### Swift ファイルを編集

1. ファイルを開く
```bash
nvim path/to/File.swift
```

2. LSP が自動的にアタッチされます
   - コード補完、定義ジャンプ、エラー表示などが利用可能

### プラグインの管理

#### プラグインを更新
```vim
:Lazy update
```

#### プラグイン一覧を表示
```vim
:Lazy
```

## ディレクトリ構造

```
~/.config/nvim/
├── .env                        # 環境変数（自動生成、gitignore対象）
├── .env.example                # 環境変数テンプレート
├── .gitignore                  # Git除外設定
├── setup.sh                    # セットアップスクリプト
├── README.md                   # このファイル
├── init.lua                    # メイン設定ファイル
├── lua/
│   ├── config/
│   │   ├── env.lua            # 環境変数管理
│   │   ├── options.lua        # エディタ基本設定
│   │   └── keymaps.lua        # キーマッピング
│   └── plugins/
│       ├── lsp.lua            # LSP設定
│       ├── completion.lua     # 補完設定
│       ├── xcodebuild.lua     # iOS開発支援
│       ├── dap.lua            # デバッグ設定
│       ├── telescope.lua      # ファジーファインダー
│       ├── nvim-tree.lua      # ファイルエクスプローラー
│       ├── treesitter.lua     # シンタックスハイライト
│       └── colorscheme.lua    # カラースキーム
└── undo/                       # Undoファイル（gitignore対象）
```

## トラブルシューティング

### LSP が動作しない場合

1. SourceKit-LSP がインストールされているか確認
```bash
which sourcekit-lsp
```

2. 環境変数を確認
```bash
cat ~/.config/nvim/.env
```

3. セットアップスクリプトを再実行
```bash
cd ~/.config/nvim
./setup.sh
```

### xcodebuild.nvim が動作しない場合

1. Xcodeがインストールされているか確認
```bash
xcodebuild -version
```

2. プロジェクトのルートディレクトリで起動しているか確認

### プラグインのエラー

プラグインを再インストール:
```vim
:Lazy clean
:Lazy install
```

### 異なるマシンでの動作

セットアップスクリプトは各マシンの環境を自動検出するため、Xcodeのバージョンやパスが異なっても正しく動作します。

## カスタマイズ

### 環境変数を変更

`.env` ファイルを編集して、設定を変更できます：

```bash
# .env
IOS_SDK_PATH=/path/to/custom/sdk
IOS_TARGET=x86_64-apple-ios17.5-simulator
COLORSCHEME=gruvbox
```

変更後、NeoVimを再起動してください。

### プラグインを追加

`lua/plugins/` ディレクトリに新しいファイルを作成：

```lua
-- lua/plugins/my-plugin.lua
return {
  {
    "author/plugin-name",
    config = function()
      -- プラグインの設定
    end,
  },
}
```

## 参考資料

- [Zero to Swift in Neovim](https://www.swift.org/documentation/articles/zero-to-swift-nvim.html)
- [iOS開発のためのNeoVim設定ガイド](https://findy-code.io/engineer-lab/oshi-editor-the-uhooi)
- [xcodebuild.nvim GitHub](https://github.com/wojciech-kulik/xcodebuild.nvim)
- [lazy.nvim](https://github.com/folke/lazy.nvim)

## ライセンス

MIT

## 貢献

プルリクエストを歓迎します！
