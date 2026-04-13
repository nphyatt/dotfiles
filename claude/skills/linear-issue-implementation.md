---
name: linear-issue-implementation
description: Use when the user asks to work on the next issue, implement a task, start coding, or begin the next highest priority item. Triggers on phrases like "work on the next issue", "start implementing", "what's next", "begin the next task", or any intent to pick up and implement a Linear issue. Requires Linear MCP and GitHub access.
---

You are helping the user implement the next highest-priority Linear issue. This skill governs the full lifecycle from pulling the issue → planning → implementation → tests → PR.

This skill enforces a strict sequence. Do not skip phases. Do not write implementation code before the plan is approved.

---

## Phase 1 — Pull the Next Issue

Use the Linear MCP to fetch open issues for the current project, ordered by priority (Urgent first, then High, Medium, Low).

Display the top issue to the user:
```
Next issue: [THR-14] Implement OAuth2 login flow
Priority: High
Blocks: —
Blocked by: THR-13 (confirm this is resolved before proceeding)
```

If the top issue is blocked by an incomplete issue, surface that and ask the user which issue to work on instead. Do not silently skip blockers.

Wait for the user to confirm this is the issue they want to work on.

---

## Phase 2 — Load Context

Before planning, load all relevant context:

1. **Read the issue description** in full from Linear — do not rely on memory
2. **Read the project spec** from `docs/specs/` — find the spec file for this project and load relevant sections
3. **Check the codebase** for any existing code that this issue touches or depends on

Summarize what you've loaded:
- Issue goal and acceptance criteria
- Relevant spec decisions that apply
- Existing code patterns to follow
- Any ambiguities that need clarification before planning

Ask the user to resolve any ambiguities before proceeding. One question at a time.

---

## Phase 3 — Create the Issue Branch

Create a branch following Linear's naming convention:
```
feature/[linear-identifier]-[kebab-case-issue-title]
```

Example: `feature/thr-14-implement-oauth2-login-flow`

You can retrieve the suggested branch name from Linear via MCP if available. Create it from `main` (or the appropriate base branch for the project).

Confirm the branch was created and you are on it before writing any code.

---

## Phase 4 — Write the Implementation Plan

Before writing any implementation code, produce a written plan. This is mandatory.

The plan must include:

### Implementation Plan: [Issue Title]

**Approach**: 1–2 sentences describing the overall implementation strategy and key decision made.

**Tasks** (ordered, each completable in a focused session):
```
[ ] 1. [Specific task] — [files affected] — [verification: how we know it's done]
[ ] 2. ...
[ ] 3. ...
```

**Test strategy**: What tests will be written? Unit, integration, or e2e? What are the key test cases?

**Rollback / risk**: Any risky changes? What's the plan if something breaks?

Save the plan to:
```
docs/plans/[linear-identifier]-[slug]-plan.md
```

Present the plan to the user and wait for explicit approval before writing any implementation code. If the user requests changes, update the plan and re-present.

---

## Phase 5 — Implement with TDD

Invoke `superpowers:test-driven-development` for all implementation work.

Work through the plan tasks in order:
- Mark each task `[x]` in the plan file as it is completed
- For each task: write failing test → confirm it fails → write minimal implementation → confirm tests pass → commit
- Commit message format: `[THR-14] [short description of what this commit does]`

Do not move to the next task until the current task's tests pass and the task is committed.

If you encounter a blocker or ambiguity mid-implementation, stop and surface it to the user. Do not make unilateral architectural decisions — check the spec first, then ask the user if the spec doesn't cover it.

---

## Phase 6 — Verification Before PR

Before opening the PR, run the full verification checklist:

```
[ ] All plan tasks marked complete
[ ] All new code has tests
[ ] Full test suite passes (no regressions)
[ ] Linter/type-checker passes (if applicable)
[ ] No debug code, console.logs, or TODOs left in implementation code
[ ] Branch is up to date with main (rebase if needed)
[ ] Issue acceptance criteria from Linear are all met
```

If any item fails, fix it before opening the PR. Do not open a PR with failing tests.

---

## Phase 7 — Open the GitHub PR

Open a PR from the issue branch to `main`:

**Title**: `[THR-14] [Issue title]`

**Body template**:
```markdown
## Summary
[1–3 sentences describing what was implemented and why]

## Changes
- [Key change 1]
- [Key change 2]

## Test coverage
- [What was tested and how]

## Linear
Closes [THR-14]
```

The `Closes [THR-14]` line triggers the Linear/GitHub integration to automatically close the issue and move it to Done when the PR merges.

Confirm the PR URL to the user. The implementation skill is complete.

---

## Phase Gates (Do Not Skip)

```
Pull highest-priority open issue
        ↓ [user confirms issue]
Load issue + spec + codebase context
        ↓ [ambiguities resolved]
Create feature branch
        ↓ [confirm on correct branch]
Write implementation plan
        ↓ [user approves plan]
Implement with TDD (task by task)
        ↓ [all tasks complete, tests pass]
Verification checklist
        ↓ [all checks green]
Open GitHub PR
        ↓ [confirm PR URL]
DONE — await user merge
```

Never proceed past a gate without completing it fully.

---

## Branch Naming Reference

```
feature/[team-key]-[issue-number]-[issue-title-kebab-case]
```

Always retrieve from Linear MCP if possible. Construct manually from the issue identifier and title if not. Never use ad-hoc branch names.

---

## Do Nots

- Do NOT write implementation code before the plan is approved
- Do NOT skip tests — every implementation task needs test coverage
- Do NOT open a PR with failing tests or failing verification checks
- Do NOT merge the PR yourself — the user merges
- Do NOT make architectural decisions not covered by the spec without checking with the user
- Do NOT pick a different issue than the highest-priority open one without surfacing the reason and getting user confirmation
