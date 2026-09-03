# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 仓库性质

这是一个 Claude Code plugin marketplace 仓库，不是应用代码。里面没有构建产物、依赖或运行时——全部内容是 JSON 清单和 Markdown 指令文件，由 Claude Code 客户端在安装插件时读取。因此没有 build / lint / test 工具链，校验手段只有 `claude plugin validate`。

## 发布方式

本 marketplace 托管在 GitHub 的 `qingweiqu/dev-tools`，用户通过 `owner/repo` 简写安装。这个简写解析的是**仓库默认分支（main）**，所以"发布"就等于把改动推到 main——没有单独的发布流程、构建步骤或版本 tag 要求。推上去之后，已安装用户执行 `/plugin marketplace update dev-tools` 才会拿到更新。

由此产生两条约束：

- main 上的清单必须始终是合法的。推之前跑 `claude plugin validate .`，坏掉的清单会让所有用户的 marketplace 加载失败。
- 改动要一次推完整。只推了 `marketplace.json` 而漏推插件目录，会导致 `source` 指向不存在的路径。

## 常用命令

```bash
# 校验 marketplace 清单（改完 .claude-plugin/marketplace.json 必跑）
claude plugin validate .

# 校验单个插件清单
claude plugin validate ./plugins/<plugin-name>
```

本地开发插件时，在 Claude Code 会话里用绝对路径加载本仓库，改文件后重新加载即可生效，不需要提交或推送：

```
/plugin marketplace add /Users/quqw/data/source_code/dev-tools
```

## 结构约定

两个清单文件的路径是 Claude Code 硬性要求的，不能移动或改名：

- `.claude-plugin/marketplace.json` —— 仓库根的 marketplace 清单，`plugins` 数组列出所有插件
- `plugins/<name>/.claude-plugin/plugin.json` —— 每个插件自己的清单

marketplace 清单里的 `source` 对同仓库插件用相对路径（`./plugins/<name>`）；引用外部仓库时改用 `{"source": "git-subdir", "url": ..., "path": ..., "ref": ...}` 对象形式。

插件内部 `commands/`、`skills/`、`agents/` 三个目录是**约定扫描路径**，Claude Code 自动发现其中的文件，不需要也不应该在 `plugin.json` 里逐个声明。只有把它们放到非默认位置时，才用 `plugin.json` 的 `commands` / `skills` / `agents` 字段指向自定义路径。

## 三类扩展的区别

写新能力前先确定它属于哪一类，这决定文件放哪、frontmatter 怎么写：

| 类型 | 位置 | 触发方式 |
|------|------|----------|
| command | `commands/<name>.md` | 用户手动输入 `/<name>` |
| skill | `skills/<name>/SKILL.md` | 模型读 `description` 自主判断是否加载 |
| agent | `agents/<name>.md` | 模型派发子任务，跑在独立上下文 |

skill 的 `description` 是它唯一的触发依据，必须写进用户可能说出的具体短语和关键词，而不是泛泛描述功能；不同 skill 的触发条件不要重叠。篇幅长的内容拆到 skill 目录下的 `references/` 按需加载，避免一次性占满上下文。

## 新增插件的步骤

1. 在 `plugins/` 下新建目录，照 `plugins/qqw-dev/` 的结构建 `.claude-plugin/plugin.json`
2. `plugin.json` 的 `name` 须与目录名一致，另填 `description`、`version`
3. 按上表把 command / skill / agent 放进对应目录
4. 在 `.claude-plugin/marketplace.json` 的 `plugins` 数组追加一条，`source` 指向新目录
5. 跑 `claude plugin validate .` 确认清单合法
6. 更新根 README.md 的插件列表表格
