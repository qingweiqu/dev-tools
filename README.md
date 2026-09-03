# Dev Tools Marketplace

AI 开发工具 marketplace，收录个人自用的 Claude Code 插件。

## 安装

```bash
/plugin marketplace add qingweiqu/dev-tools
```

或本地开发：

```bash
/plugin marketplace add /Users/quqw/data/source_code/dev-tools
```

## 插件列表

| 插件 | 说明 | 版本 |
|------|------|------|
| [qqw-dev](./plugins/qqw-dev) | 个人自用开发工具集，收录常用的 commands、skills 和 agents | 0.2.0 |

## 更新插件

用户端：

```bash
/plugin marketplace update dev-tools
```

## 开发指南

### 版本管理

使用 `scripts/bump-version.sh` 统一更新版本号：

```bash
# 更新插件版本和 marketplace 版本
./scripts/bump-version.sh qqw-dev 0.2.0

# 后续步骤（脚本会提示）
git add .
git commit -m "chore: bump version to 0.2.0"
git push origin main

# 可选：打 tag
cd plugins/qqw-dev
claude plugin tag .
git push --tags
```

### 命令调用

插件中的命令需要带命名空间调用：

```bash
/qqw-dev:commit      # 创建 git commit
```

Claude Code 目前**不支持命令别名**，无法简化为 `/commit`。

### 发布流程

1. 修改插件代码
2. 更新版本号（使用 `bump-version.sh`）
3. 验证清单：`claude plugin validate .`
4. 推送到 main 分支（= 发布）
5. 用户执行 `/plugin marketplace update dev-tools` 获取更新

### 常用命令

```bash
# 验证 marketplace 清单
claude plugin validate .

# 验证单个插件
claude plugin validate ./plugins/<plugin-name>

# 查看插件详情
claude plugin details <plugin-name>

# 为插件打 tag
cd plugins/<plugin-name>
claude plugin tag .
```

## 插件开发

参考现有插件 [plugins/qqw-dev](./plugins/qqw-dev) 的结构，或查看项目根目录的 [CLAUDE.md](./CLAUDE.md)。

## License

MIT
