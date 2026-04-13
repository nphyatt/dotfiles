---
name: linear-project-planning
description: Use when creating a new Linear project, planning a new feature or initiative, brainstorming a project spec, or breaking a spec into Linear issues. Triggers on phrases like "new project", "let's plan", "create a project in Linear", "brainstorm a feature", or any intent to start a chunk of work that doesn't yet have a Linear project. Requires Linear MCP to be connected.
---

You are helping the user define, specify, and structure a new project in Linear. This skill governs the full lifecycle from raw idea → Linear project → spec issue → brainstormed spec → issue breakdown with priorities.

This skill MUST be used before any implementation work begins on a new initiative. Do not skip or abbreviate any phase. Each phase gate requires explicit user approval before proceeding.

---

## Phase 1 — Create the Linear Project

Before anything else, create the Linear project to anchor all work.

Use the Linear MCP to:
1. Create a new project with the user's proposed name
2. Set a clear one-sentence description of the project goal
3. Confirm the project was created and show the user the project identifier

Ask the user for the project name and goal if not already provided. One question at a time.

---

## Phase 2 — Create the Spec Issue (Issue #1)

Immediately after creating the project, create the first issue in Linear:

- **Title**: `Create project spec: [Project Name]`
- **Description**: `Deliverable: a complete project spec covering goals, scope, technical decisions, and task breakdown. Output from brainstorming session. To be merged via PR on branch feature/[linear-identifier]-project-spec.`
- **Priority**: Urgent (highest)
- **Status**: In Progress (this issue is what we are doing right now)

Confirm creation and show the user the issue identifier (e.g. `THR-12`). This identifier is used for the branch name.

---

## Phase 3 — Brainstorm the Spec

Invoke the `superpowers:brainstorming` skill now. Do NOT skip this. Do NOT write code or create other issues yet.

The brainstorming session must produce a spec document covering:

### Required Spec Sections
1. **Goal** — What problem does this solve? What does success look like?
2. **Scope** — What is explicitly in scope? What is explicitly out of scope?
3. **Users / Stakeholders** — Who uses this? What do they need?
4. **Technical Decisions** — Key architectural choices and rationale. Alternatives considered and why they were rejected.
5. **Data Model** — Key entities, relationships, state shape (if applicable)
6. **API / Interface Contracts** — Endpoints, inputs/outputs, or component interfaces
7. **Task Outline** — High-level list of logical implementation tasks (not yet broken into issues — that's Phase 5)
8. **Open Questions** — Unresolved decisions that need to be answered before or during implementation

Follow the brainstorming skill's Socratic process: ask one question at a time, propose 2–3 alternatives for key decisions, validate each section before moving to the next.

When the user approves the spec, write it to:
```
docs/specs/[YYYY-MM-DD]-[linear-project-slug]-spec.md
```

Commit the file with message: `docs: add spec for [Project Name] ([issue-identifier])`

---

## Phase 4 — Branch and PR for the Spec Issue

Create a branch following Linear's naming convention:
```
feature/[linear-identifier]-[kebab-case-title]
```

Example: `feature/thr-12-user-authentication-spec`

The branch name comes from the spec issue identifier created in Phase 2.

1. Create the branch from main
2. The spec file committed in Phase 3 should be on this branch
3. Open a GitHub PR with:
   - **Title**: `[THR-12] Create project spec: [Project Name]`
   - **Body**: Link to the Linear issue, paste the spec summary (Goal + Scope sections only)
   - **Branch**: `feature/[identifier]-[slug]` → `main`

The Linear/GitHub integration will automatically close the spec issue when the PR merges. Confirm to the user that the PR is open and the spec issue will close on merge.

Do NOT merge the PR yourself. The user merges.

---

## Phase 5 — Break the Spec into Linear Issues

After the user has reviewed and approved the spec (they do not need to have merged the PR yet), create Linear issues for each logical implementation task.

### Issue Creation Rules

For each task in the spec's Task Outline:

**Title**: Clear, action-oriented. E.g. `Implement OAuth2 login flow`

**Description must include**:
- What needs to be built (specific, not vague)
- Relevant decisions from the spec that apply to this task (copy or paraphrase, don't just say "see spec")
- Acceptance criteria — a short checklist of what "done" looks like
- Any dependencies on other issues (reference by Linear identifier once created)

**Priority**:
- Urgent — foundational/infrastructure tasks that block everything else
- High — core feature work
- Medium — secondary features, non-blocking enhancements
- Low — nice-to-haves, polish

**Ordering rule**: Issues that are prerequisites or blockers for other issues MUST be created first and assigned higher priority. Explicitly note blocking relationships in the description: `Blocks: THR-14, THR-15`.

After creating all issues, show the user a summary table:
```
| Identifier | Title | Priority | Blocks |
|------------|-------|----------|--------|
| THR-13     | ...   | Urgent   | THR-14 |
| THR-14     | ...   | High     | —      |
```

Ask the user to review and confirm the order and priorities before considering this phase complete.

---

## Phase Gates (Do Not Skip)

```
Create Linear Project
        ↓ [confirm project created]
Create Spec Issue (Issue #1)
        ↓ [confirm issue created, note identifier]
Brainstorm → Spec Document
        ↓ [user approves spec]
Commit spec file, create branch, open PR
        ↓ [confirm PR open]
Break spec into issues with priorities
        ↓ [user approves issue list]
DONE — ready for implementation
```

Never proceed past a gate without the user's explicit approval.

---

## Branch Naming Reference

Linear generates branch names automatically in the format:
```
feature/[team-key]-[issue-number]-[issue-title-kebab-case]
```

You can retrieve the suggested branch name from Linear via MCP if available, or construct it manually from the issue identifier and title. Always use this format — do not invent other formats.

---

## Do Nots

- Do NOT start implementing any code during this skill
- Do NOT create issues before the spec is approved
- Do NOT skip brainstorming even if the user thinks the idea is simple
- Do NOT merge the spec PR yourself
- Do NOT create vague issues like "implement backend" — every issue must be specific enough to implement without re-reading the whole spec
