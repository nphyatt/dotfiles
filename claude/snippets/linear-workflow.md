# ThruStack Development Workflow

## Project Management

All work is tracked in Linear. Claude Code has access to Linear via MCP.

### Starting a new project or feature initiative
Use the `linear-project-planning` skill. This is mandatory before any implementation begins on a new initiative. Never create a Linear project, spec, or issue breakdown manually — always go through this skill.

Triggers: "new project", "plan a feature", "let's spec out", "create a project in Linear", or any intent to start a chunk of work that doesn't yet have a Linear project.

### Implementing the next task
Use the `linear-issue-implementation` skill. Always pull from Linear to determine priority — never assume what the next task is from memory or conversation context alone.

Triggers: "work on the next issue", "what's next", "let's implement", "start coding", "begin the next task".

---

## Branch Naming

All branches must follow Linear's convention:
```
feature/[team-key]-[issue-number]-[issue-title-kebab-case]
```
Example: `feature/thr-14-implement-oauth2-login-flow`

Never use ad-hoc branch names. Retrieve from Linear MCP when possible.

---

## PR Convention

- Title: `[IDENTIFIER] Issue title`
- Body must include `Closes [IDENTIFIER]` to auto-close the Linear issue on merge
- Never merge PRs — open them and let the user merge

---

## Spec Files

Project specs live in: `docs/specs/[YYYY-MM-DD]-[project-slug]-spec.md`
Implementation plans live in: `docs/plans/[identifier]-[slug]-plan.md`

These are committed to the repo and referenced during implementation. Always read the relevant spec before planning any implementation work.

---

## Skills Required

- `linear-project-planning` — new projects from idea to issue backlog
- `linear-issue-implementation` — issue pickup through PR
- `superpowers:brainstorming` — used inside linear-project-planning for spec creation
- `superpowers:test-driven-development` — used inside linear-issue-implementation for all coding
