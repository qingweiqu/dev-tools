# qqw-dev

个人自用开发工具集。

## 安装

```
/plugin install qqw-dev@dev-tools
```

## 包含的能力

| 类型 | 文件 | 触发方式 |
|------|------|----------|
| command | `commands/commit.md` | 用户输入 `/commit`，读取 git status/diff 后一次性 stage 并提交 |

## 目录结构

```
qqw-dev/
├── .claude-plugin/
│   └── plugin.json     # 插件清单，必需
├── README.md
└── commands/
    └── commit.md       # slash command，用户手动触发
```

`skills/`、`agents/` 也是 Claude Code 的约定扫描目录，等有实际文件时再建，
不需要在 `plugin.json` 里声明。三类扩展的区别和写法参照 [example-plugin](../example-plugin)。
