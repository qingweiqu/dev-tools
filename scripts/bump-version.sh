#!/bin/bash
# 统一更新插件版本和 marketplace 版本
# 用法: ./scripts/bump-version.sh <plugin-name> <new-version>

set -e

if [ $# -ne 2 ]; then
  echo "用法: $0 <plugin-name> <new-version>"
  echo "示例: $0 qqw-dev 0.2.0"
  exit 1
fi

PLUGIN_NAME="$1"
NEW_VERSION="$2"
PLUGIN_DIR="plugins/$PLUGIN_NAME"
PLUGIN_JSON="$PLUGIN_DIR/.claude-plugin/plugin.json"
MARKETPLACE_JSON=".claude-plugin/marketplace.json"

# 验证版本号格式（简单的 semver 检查）
if ! echo "$NEW_VERSION" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+'; then
  echo "错误: 版本号必须符合 semver 格式（如 0.2.0）"
  exit 1
fi

# 检查插件目录是否存在
if [ ! -d "$PLUGIN_DIR" ]; then
  echo "错误: 插件目录不存在: $PLUGIN_DIR"
  exit 1
fi

# 更新插件版本
echo "更新 $PLUGIN_JSON 版本为 $NEW_VERSION..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  sed -i '' "s/\"version\": \"[^\"]*\"/\"version\": \"$NEW_VERSION\"/" "$PLUGIN_JSON"
else
  # Linux
  sed -i "s/\"version\": \"[^\"]*\"/\"version\": \"$NEW_VERSION\"/" "$PLUGIN_JSON"
fi

# 更新 marketplace 版本
echo "更新 $MARKETPLACE_JSON 版本为 $NEW_VERSION..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s/\"version\": \"[^\"]*\"/\"version\": \"$NEW_VERSION\"/" "$MARKETPLACE_JSON"
else
  sed -i "s/\"version\": \"[^\"]*\"/\"version\": \"$NEW_VERSION\"/" "$MARKETPLACE_JSON"
fi

# 验证清单
echo "验证清单合法性..."
claude plugin validate .

echo "✅ 版本更新完成: $NEW_VERSION"
echo ""
echo "后续步骤:"
echo "  1. 提交更改: git add . && git commit -m 'chore: bump version to $NEW_VERSION'"
echo "  2. 推送到 GitHub: git push origin main"
echo "  3. 打 tag: cd $PLUGIN_DIR && claude plugin tag . && git push --tags"
