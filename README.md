# dev-tools

AI 开发工具 —— 一个 Claude Code plugin marketplace。

## 安装

在 Claude Code 里执行，`owner/repo` 简写会从 GitHub 拉取本仓库的默认分支：

```
/plugin marketplace add qingweiqu/dev-tools
```

然后浏览并安装插件：

```
/plugin
```

也可以直接指定插件安装：

```
/plugin install example-plugin@dev-tools
```

## 更新

本仓库有新提交后，已安装的用户执行：

```
/plugin marketplace update dev-tools
```

## 本地开发

改插件时用绝对路径加载本地目录，免提交即时生效：

```
/plugin marketplace add /Users/quqw/data/source_code/dev-tools
```

注意本地路径和 GitHub 源不能同名共存，先 `/plugin marketplace remove dev-tools` 再切换。

## 插件列表

| 插件 | 说明 |
|------|------|
| [example-plugin](plugins/example-plugin) | 示例插件模板，演示 commands、skills、agents 三类扩展的写法 |

## 仓库结构

```
dev-tools/
├── .claude-plugin/
│   └── marketplace.json        # marketplace 清单，必需，路径固定
├── plugins/
│   └── example-plugin/         # 每个插件一个目录
│       ├── .claude-plugin/
│       │   └── plugin.json     # 插件清单，必需
│       ├── commands/           # slash commands
│       ├── skills/             # skills
│       └── agents/             # subagents
├── LICENSE
└── README.md
```

## 添加新插件

1. 在 `plugins/` 下建目录，参照 [example-plugin](plugins/example-plugin) 的结构
2. 写 `.claude-plugin/plugin.json`，至少包含 `name` 和 `description`
3. 在 `.claude-plugin/marketplace.json` 的 `plugins` 数组追加一条：

```json
{
  "name": "your-plugin",
  "description": "一句话说明这个插件做什么",
  "source": "./plugins/your-plugin",
  "category": "development"
}
```

`source` 除了同仓库的相对路径，也支持外部仓库：

```json
"source": {
  "source": "git-subdir",
  "url": "https://github.com/owner/repo.git",
  "path": "plugins/foo",
  "ref": "main"
}
```

## 校验

```bash
claude plugin validate .
```

## License

MIT
