#!/bin/bash
# NeoVim iOS Development Environment Setup Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"
ENV_EXAMPLE="$SCRIPT_DIR/.env.example"

echo "🚀 NeoVim iOS Development Environment Setup"
echo "============================================"
echo ""

# .env ファイルが既に存在する場合は確認
if [ -f "$ENV_FILE" ]; then
  echo "⚠️  .env file already exists."
  read -p "Do you want to overwrite it? [y/N]: " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Setup cancelled."
    exit 0
  fi
fi

# iOS SDK パスを自動検出
echo "📱 Detecting iOS SDK..."
IOS_SDK_PATH=$(xcrun --sdk iphonesimulator --show-sdk-path 2>/dev/null || echo "")

if [ -z "$IOS_SDK_PATH" ]; then
  echo "❌ Error: Could not detect iOS SDK path."
  echo "Please make sure Xcode and Command Line Tools are installed:"
  echo "  xcode-select --install"
  exit 1
fi

echo "✅ iOS SDK detected: $IOS_SDK_PATH"

# iOS SDK バージョンを取得
IOS_VERSION=$(xcrun --sdk iphonesimulator --show-sdk-version 2>/dev/null || echo "18.0")
echo "✅ iOS SDK version: $IOS_VERSION"

# アーキテクチャを検出
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
  IOS_TARGET="arm64-apple-ios${IOS_VERSION}-simulator"
else
  IOS_TARGET="x86_64-apple-ios${IOS_VERSION}-simulator"
fi

echo "✅ Target architecture: $IOS_TARGET"

# .env ファイルを作成
echo ""
echo "📝 Creating .env file..."

cat > "$ENV_FILE" << EOF
# NeoVim iOS Development Environment Variables
# Generated on $(date)

# iOS Simulator SDK パス
IOS_SDK_PATH=$IOS_SDK_PATH

# iOS ターゲットアーキテクチャ
IOS_TARGET=$IOS_TARGET

# リーダーキー（デフォルト: Space）
LEADER_KEY=" "

# カラースキーム（デフォルト: tokyonight）
COLORSCHEME=tokyonight
EOF

echo "✅ .env file created successfully!"

# undoディレクトリを作成
echo ""
echo "📁 Creating undo directory..."
mkdir -p "$SCRIPT_DIR/undo"
echo "✅ Undo directory created!"

# プラグインのインストール
echo ""
echo "📦 Installing NeoVim plugins..."
echo "This may take a few minutes..."

if nvim --headless "+Lazy! sync" "+qall" 2>&1 | grep -i "error"; then
  echo "⚠️  Some errors occurred during plugin installation."
  echo "Please run ':Lazy sync' manually in NeoVim."
else
  echo "✅ Plugins installed successfully!"
fi

# 設定サマリーを表示
echo ""
echo "============================================"
echo "✨ Setup completed successfully!"
echo "============================================"
echo ""
echo "Configuration:"
echo "  Config directory: $SCRIPT_DIR"
echo "  iOS SDK:          $IOS_SDK_PATH"
echo "  Target:           $IOS_TARGET"
echo ""
echo "Next steps:"
echo "  1. Start NeoVim: nvim"
echo "  2. Open a Swift file to test LSP"
echo "  3. Check LSP status: :LspInfo"
echo ""
echo "For more information, see: $SCRIPT_DIR/README.md"
echo ""
