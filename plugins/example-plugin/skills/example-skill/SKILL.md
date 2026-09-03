---
name: example-skill
description: 当用户提到"写一个 skill"、"skill 模板"、"skill 怎么写"，或需要了解 Claude Code 插件中 skill 的结构和 frontmatter 写法时使用。提供 skill 的参考模板。
version: 0.1.0
---

# Skill 示例模板

这个 skill 演示 Claude Code 插件里 skill 的结构与写法。

## skill 与 command 的区别

- **skill**：模型自主触发。模型读 `description` 判断当前任务是否相关，相关就自动加载。
- **command**：用户手动触发，形式是 `/command-name`。
- **agent**：模型派发的子任务执行者，跑在独立上下文里。

## 目录结构

必需文件只有一个：

```
skills/
└── skill-name/
    └── SKILL.md
```

复杂 skill 可以带补充文件，SKILL.md 里按需引用，避免一次性塞满上下文：

```
skills/
└── skill-name/
    ├── SKILL.md          # 主体，必需
    ├── references/       # 参考资料，需要时才读
    │   └── patterns.md
    ├── examples/         # 示例文件
    │   └── sample.md
    └── scripts/          # 辅助脚本
        └── helper.sh
```

## frontmatter 字段

- `name`：必填，skill 标识符，与目录名保持一致，kebab-case
- `description`：必填，触发条件。这是模型判断要不要加载的唯一依据
- `version`：可选，语义化版本号
- `license`：可选，许可证信息
- `allowed-tools`：可选，限制该 skill 可用的工具

## description 怎么写

`description` 决定 skill 会不会被触发，写法上要包含具体的触发短语和关键词，而不是泛泛描述功能。

推荐写法：

```yaml
description: 当用户提到"具体短语 A"、"具体短语 B"，或涉及某个明确的任务类型时使用。<一句话说明这个 skill 做什么>。
```

要写进去的内容：

- 用户可能说出的原话
- 表明相关性的关键词
- 覆盖的任务领域

## 正文内容建议

1. 开门见山说明这个 skill 解决什么问题
2. 明确适用边界，什么情况下不该用
3. 给出可执行的步骤，而不是抽象原则
4. 需要时配具体示例
5. 篇幅长的部分拆到 `references/` 里按需加载

## 注意事项

- 一个 skill 聚焦一个领域，不要做成大杂烩
- 不同 skill 的触发条件不要互相重叠，否则模型难以选择
- 写完后实测一遍：说出预期的触发语句，确认 skill 真的被加载
