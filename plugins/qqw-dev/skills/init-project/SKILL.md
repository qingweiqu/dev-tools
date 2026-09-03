---
name: init-project
description: Use when the user asks to initialize or set up a project for development (初始化项目/项目初始化), such as a freshly cloned repo or a project missing CLAUDE.md
disable-model-invocation: true
---

# 初始化项目

## Overview

"初始化项目"的核心交付物是**项目 CLAUDE.md**。补 tsconfig / README / .gitignore 之类不是本 skill 的目标,除非它们阻塞 CLAUDE.md 生成。

## 步骤

### 1. 生成 CLAUDE.md

调用 `init` skill(即 /init)在**项目根目录**生成 CLAUDE.md,用中文撰写、技术术语保留英文。若 CLAUDE.md 已存在则更新缺失部分,不要整篇覆盖。

### 2. 侦察项目

- 读 package.json / Cargo.toml / pyproject.toml / go.mod 等,确定技术栈、二进制/入口、dev 与 build 命令
- 确定端口:前端 dev server 端口读 vite/webpack 配置;后端端口读代码或配置
- 确认前端产物如何被后端使用:dev server 独立访问?后端静态服务?还是**编译期嵌入**(如 Rust `include_str!`)
- 找出运行时的**相对路径依赖**(静态目录、配置文件)

### 3. 完善 CLAUDE.md

在 CLAUDE.md 补充以下内容:

- **技术栈**:列出主要框架、语言、构建工具
- **开发命令**:dev server 启动命令、构建命令、测试命令
- **项目结构**:关键目录的用途说明
- **开发约束**:端口配置、相对路径依赖、前后端构建顺序等需要注意的点

## 完成检查

- [ ] CLAUDE.md 存在且为中文
- [ ] 技术栈、开发命令、项目结构已补充
- [ ] 开发约束(端口、路径依赖、构建顺序)已记录

## Common Mistakes

| 错误 | 后果/纠正 |
|---|---|
| 把"初始化"理解为补 README/tsconfig | 交付物是 CLAUDE.md,以完成检查清单为准 |
| 只调 /init 就完事 | /init 生成的是骨架,需要补充项目特定的技术栈和约束信息 |
