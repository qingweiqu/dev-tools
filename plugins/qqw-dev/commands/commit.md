---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git log:*), Bash(git branch:*)
description: Create a git commit
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

Based on the above changes, create a single git commit following the convention above.

You have the capability to call multiple tools in a single response. Stage and create the commit using a single message. Do not use any other tools or do anything else. Do not send any other text or messages besides these tool calls.
