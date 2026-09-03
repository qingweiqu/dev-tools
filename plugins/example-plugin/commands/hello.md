---
description: 示例 slash command，演示 command frontmatter 的可用字段
argument-hint: <name> [greeting]
allowed-tools: [Read, Glob, Grep]
---

# Hello 示例命令

用户调用时传入的参数：$ARGUMENTS

## 执行步骤

1. 解析参数：第一个参数是要打招呼的对象名字，第二个可选参数是自定义问候语
2. 如果没有传参数，提示正确用法：`/hello <name> [greeting]`
3. 输出问候语，并简要说明这是一个来自 example-plugin 的示例命令

## frontmatter 字段说明

- `description`：必填，显示在 `/help` 列表里的一句话说明
- `argument-hint`：可选，参数提示，输入命令时展示给用户
- `allowed-tools`：可选，预授权的工具列表，减少权限确认弹窗
- `model`：可选，覆盖本命令使用的模型，如 `haiku` / `sonnet` / `opus`
- `disable-model-invocation`：可选，设为 `true` 则只允许用户手动调用，模型不能自动触发

## 用法

```
/hello 世界
/hello 世界 早上好
```

> 说明：`commands/*.md` 是命令的经典布局。新写的能力如果希望由模型自动判断触发，
> 优先用 `skills/<name>/SKILL.md` 目录形式（见本插件的 skills 目录）。
