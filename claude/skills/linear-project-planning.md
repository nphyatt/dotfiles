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

After the user has reviewed and approved the spec (they do not need to have merged the PR yet), break the spec into Linear issues. This is a two-step process: first discuss the breakdown with the user, then create the issues.

### Step 1: Discuss the Issue Breakdown

Do NOT automatically create one issue per item in the spec's Task Outline. The spec organizes tasks by technical area (e.g., database, engine, API, frontend), but issues should be organized as **milestones** — small, incremental deliverables that each produce something demonstrably working and build on top of each other.

**Present a proposed milestone breakdown to the user for discussion.** Each milestone should:

- Combine work from multiple technical areas/layers as needed to achieve a working outcome
- End with something you can test or demo — not just "infrastructure is in place"
- Build on the previous milestone (each one assumes the prior milestones are complete)
- Be scoped small enough to be a single PR or a small set of related PRs
- Include testing criteria (unit tests, integration tests, E2E tests as appropriate)

**Example:** Instead of separate issues for "add database tables", "build workflow engine", "implement executor", and "update orchestrator", combine them into a single milestone: "Execute a hardcoded workflow end-to-end" — which touches all four layers but delivers a working vertical slice.

Ask the user:

- Does this milestone ordering make sense?
- Should any milestones be merged, split, or reordered?
- Are there any scope adjustments?

Wait for the user's approval of the milestone breakdown before creating any issues.

### Step 2: Create Issues

Once the user approves the milestone breakdown, create one Linear issue per milestone.

**Title**: `Milestone N: [Clear, outcome-oriented title]`

**Description must include**:

- What needs to be built, organized by which technical areas/packages are touched
- Relevant decisions from the spec that apply to this milestone (copy or paraphrase, don't just say "see spec")
- Testing criteria — a checklist of unit tests, integration tests, and E2E tests
- Dependencies on other milestones (reference by Linear identifier once created)

**Priority**:

- Urgent — the first milestone(s) that everything else depends on
- High — core milestones on the critical path
- Medium — milestones that add important but non-foundational capabilities
- Low — nice-to-haves, polish

**Ordering rule**: Set blocking relationships between milestones to enforce the sequential build-up. Use Linear's `blockedBy` field so milestones cannot be started out of order.

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
Discuss milestone breakdown with user
        ↓ [user approves milestone grouping]
Create milestone issues in Linear
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
- Do NOT create issues by mapping spec task outline items 1:1 to issues — the spec organizes by technical area, but issues must be organized as milestones (working vertical slices that build on each other). Always discuss the milestone breakdown with the user before creating any issues.
