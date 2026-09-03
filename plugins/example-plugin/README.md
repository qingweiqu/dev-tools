# example-plugin

示例插件模板，演示 Claude Code 插件的三类扩展能力。复制这个目录就能改造成新插件。

## 目录结构

```
example-plugin/
├── .claude-plugin/
│   └── plugin.json                 # 插件清单，必需
├── README.md
├── commands/
│   └── hello.md                    # slash command，用户手动触发
├── skills/
│   └── example-skill/
│       └── SKILL.md                # skill，模型自主触发
└── agents/
    └── example-agent.md            # subagent，模型派发
```

`commands/`、`skills/`、`agents/` 都是可选的，按需保留。目录名是约定，Claude Code 会自动扫描，
不需要在 `plugin.json` 里逐个声明（除非要改成非默认路径，那时用 `commands` / `skills` / `agents` 字段指向自定义目录）。

## 包含的示例

| 类型 | 文件 | 触发方式 |
|------|------|----------|
| command | `commands/hello.md` | 用户输入 `/hello <name>` |
| skill | `skills/example-skill/SKILL.md` | 模型读 description 自主判断 |
| agent | `agents/example-agent.md` | 模型派发子任务 |

## 改造成新插件

1. 复制整个目录，重命名为你的插件名
2. 改 `.claude-plugin/plugin.json` 里的 `name`、`description`、`version`
3. 删掉不需要的示例文件，写自己的 command / skill / agent
4. 在仓库根的 `.claude-plugin/marketplace.json` 的 `plugins` 数组里追加一条，`source` 指向新目录

## 其他可选能力

本示例没有覆盖，需要时可以加：

- `hooks/hooks.json` — 在工具调用前后自动执行的钩子
- `.mcp.json` — 随插件一起安装的 MCP server 配置
- `settings.json` — 插件级默认设置
