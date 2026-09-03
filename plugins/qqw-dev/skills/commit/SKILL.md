---
name: commit
description: 当用户要求创建 git commit、提交代码、生成 commit message 时使用。触发词：commit、提交、git commit、生成提交信息、创建 commit
argument-hint: [optional: commit message]
disable-model-invocation: true
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git log:*), Bash(git branch:*)
model: haiku
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Commit message convention

Follow Conventional Commits:

```
<type>(<scope>): <subject>

[optional body]


[optional footer(s)]
```

### Types

| Type | Use for | Example |
|------|---------|---------|
| `feat` | New feature | `feat(auth): add OAuth2 login` |
| `fix` | Bug fix | `fix(api): handle null response in user endpoint` |
| `docs` | Documentation | `docs(readme): update installation instructions` |
| `style` | Formatting, no code change | `style: fix indentation in login component` |
| `refactor` | Code refactoring | `refactor(db): extract connection pool to module` |
| `test` | Adding/updating tests | `test(auth): add unit tests for token validation` |
| `chore` | Maintenance tasks | `chore(deps): update dependencies` |
| `perf` | Performance improvement | `perf(query): add index to users table` |
| `ci` | CI/CD changes | `ci: add PostgreSQL service to test workflow` |
| `revert` | Revert previous commit | `revert: revert "feat(auth): add OAuth2 login"` |

### Rules

- `<scope>` is optional; use it when the change is confined to one module or area.
- `<subject>`: imperative mood, lowercase, no trailing period, under ~70 characters.
- Add a body when the *why* is not obvious from the subject. Wrap at 72 characters, explain the reason for the change rather than restating the diff.
- Use footers for issue references (`Closes #123`) or `BREAKING CHANGE: <description>`.
- Match the style of the recent commits shown above — if this repo already writes subjects in another language, keep doing that.
- Do not add `Co-Authored-By` or any tool-attribution trailer.

### Good vs bad

```
# BAD: vague, no context
fixed stuff
updates
WIP

# GOOD: clear, specific, explains why
fix(api): retry requests on 503 Service Unavailable

The external API occasionally returns 503 errors during peak hours.
Added exponential backoff retry logic with max 3 attempts.

Closes #123
```

## Your task

Create a git commit with the changes shown above.

**If a commit message is provided** (`$ARGUMENTS` is not empty):
- Use `$ARGUMENTS` as the commit message exactly as provided

**If no message is provided** (`$ARGUMENTS` is empty):
- Analyze the changes from the git diff
- Generate a concise, meaningful commit message following the Conventional Commits convention above
- The message should clearly describe what changed and why

## Steps

1. Check `git status` to see current state
2. If nothing is staged, run `git add .` to stage all changes
3. Review what will be committed with `git diff --staged`
4. Create the commit:
   - If `$ARGUMENTS` is provided, use it as the commit message
   - Otherwise, generate a commit message based on the diff following the convention above
5. Show the commit result

## Output

Show a brief confirmation with the commit message and files changed:

```
✓ Committed: [commit message]
  [number] files changed
```
