---
name: decision-notes
description: Manages decision memo lifecycle including creation, implementation tracking, archiving, and INDEX maintenance. Ensures memos are task directives (not knowledge sources) with proper YAML metadata.
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Decision Notes Skill

## Purpose

Manages the decision memo lifecycle for research projects. Decision memos are task directives that coordinate bounded repository changes—they are NOT authoritative knowledge sources.

## Critical Principle

**Decision memos instruct changes; they don't provide evidence.**

If a memo changes knowledge claims, the resulting knowledge modules must have their own provenance to authoritative sources (literature, data, manuscripts)—not to the decision memo itself.

## Embedded Template

Use this template for new decision memos:

```yaml
---
type: decision_memo
status: proposed
created: YYYY-MM-DD
source: claude_web | chatgpt_web | human | mixed | claude_code
topic: topic_slug
targets:
  - path: relative/path/to/file
    change_type: edit | create | delete
requires_evidence: false
implementation:
  commit: ""
  implemented_by: ""
  implemented_on: ""
supersedes: []
superseded_by: []
---

# Title: Short Description

## Context

Why is this change needed? What problem does it solve?

## Decision

What change will be made?

## Targets

- `path/to/file1`: What changes
- `path/to/file2`: What changes

## Implementation Plan

1. Step one
2. Step two

## Acceptance Criteria

- [ ] Criterion 1
- [ ] Criterion 2
```

## File Naming Convention

`YYYY-MM-DD__topic__short-slug.md`

Examples:

- `2026-02-01__skills__hierarchical-structure.md`
- `2026-01-24__restructuring__knowledge-directory-move.md`
- `2026-01-15__manuscript__paper1-revision.md`

## Workflow

### Phase 1: Create Memo

1. Use embedded template above
2. Fill in all YAML fields
3. Set `status: proposed`
4. Place in `ai/decisions/`

### Phase 2: Review and Accept

1. Project lead reviews memo
2. If approved: set `status: accepted`
3. Update `ai/decisions/INDEX.md`

### Phase 3: Implement

1. Read the accepted memo
2. Execute changes per implementation plan
3. Keep changes bounded to listed targets
4. If `requires_evidence: true`:
   - Create/update knowledge modules with provenance
   - Do NOT cite the memo as a source

### Phase 4: Close Out

1. Update memo YAML:
   - Set `status: implemented`
   - Fill `implementation.commit`, `implemented_by`, `implemented_on`
2. Update `ai/decisions/INDEX.md`
3. Move memo to `ai/decisions/archive/`
4. Commit closeout changes

## INDEX.md Structure

The decision queue INDEX should include:

```markdown
# Decision Memo Index

## Active Queue

| Created | Memo | Topic | Status | Targets |
|---------|------|-------|--------|---------|
| 2026-02-01 | [memo-name.md](memo-name.md) | topic | accepted | files |

## Knowledge Module Grounding Status

Track which evidence-requiring memos have corresponding knowledge modules:

| Memo | requires_evidence | Knowledge Module | Status |
|------|-------------------|------------------|--------|
| memo-name | true | module-name.md | ✅ Grounded |
| other-memo | true | *(pending)* | ⚠️ Pending |

## Implemented / Closed

| Created | Memo | Commit | Implemented |
|---------|------|--------|-------------|
| 2026-01-15 | [archived/memo.md](archive/memo.md) | abc123 | 2026-01-20 |
```

## Status Meanings

- **proposed**: Candidate; not yet endorsed
- **accepted**: Approved for implementation
- **implemented**: Changes applied; commit recorded
- **superseded**: Replaced by another memo
- **abandoned**: Intentionally not pursued

## When to Use This Skill

Invoke `/decision-notes` when:

- Creating a new decision memo
- Implementing the lifecycle (accept → implement → archive)
- Updating INDEX.md queue status
- Managing grounding status tracking
- Checking memo YAML compliance

## Anti-Patterns

1. **Citing memos as evidence**: Memos are tasks, not knowledge
2. **Unbounded scope**: Adding changes beyond listed targets
3. **Missing closeout**: Forgetting to archive and update INDEX
4. **Stale queue**: Leaving implemented memos in active queue
5. **Missing grounding**: Evidence-requiring memos without knowledge modules

## Common Operations

### Create new decision memo

```bash
# Generate filename
DATE=$(date +%Y-%m-%d)
FILENAME="${DATE}__topic__short-slug.md"

# Create in decisions directory
touch ai/decisions/$FILENAME
```

### Check for stale memos

```bash
# Find implemented memos not yet archived
grep -l "status: implemented" ai/decisions/*.md 2>/dev/null
```

### Validate memo YAML

Check that all required fields are present:

- `type: decision_memo`
- `status:`
- `created:`
- `source:`
- `topic:`
- `targets:`
- `requires_evidence:`
- `implementation:`

### Update grounding status

For memos with `requires_evidence: true`:

1. Check if corresponding knowledge module exists
2. Verify module has provenance to authoritative sources
3. Update INDEX.md grounding status table

## Integration with Knowledge-Integrity

This skill is a sub-skill of `/knowledge-integrity`. The parent skill delegates to `/decision-notes` for memo lifecycle management but handles knowledge module changes directly.

Delegation pattern:

- `/decision-notes`: Memo creation, status updates, INDEX management
- `/knowledge-integrity`: Provenance validation, claim ledgers, evidence snippets
