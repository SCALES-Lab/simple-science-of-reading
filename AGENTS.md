# AGENTS.md

This file defines working rules for assistants contributing to this repository.

## Project scope

This project develops **SVR-DD** (**Simple View of Reading — Developmental Dynamics**), a developmental modeling framework for comparing mechanistic accounts of reading growth from the elementary through middle-school years.

Assistants may help with literature organization, source notes, data workflows, model specification, drafting, revision, and project documentation. The researcher remains responsible for interpretation, evidentiary judgment, and final decisions.

## Project-local skills

Before beginning a task, check `ai/skills/` for project-local skills relevant to the work. These skills are part of the repository context and should be used when applicable.

Available project-local skills include:

- `ai/skills/knowledge-integrity/SKILL.md` — use for work involving evidence boundaries, provenance, or durable project knowledge
- `ai/skills/decision-notes/SKILL.md` — use when creating or updating decision records
- `ai/skills/source-notes/SKILL.md` — use when creating or updating notes on source materials

When both project-local skills and global instructions apply, follow the project-local skill for repository-specific workflow details unless it conflicts with higher-priority instructions.

## File roles 

Keep different kinds of project material separate.

| Material type | Purpose | Typical locations |
|---|---|---|
| **Evidence** | Primary sources, project data, and completed analyses | `sources/`, `data/`, analysis outputs |
| **Project knowledge** | Durable claims that have been checked against evidence | `knowledge/` |
| **Planning and process records** | Decisions, task history, drafts, and work-in-progress notes | `ai/`, planning files |

Do not treat planning files, draft text, or prior assistant output as evidence for research claims.

## Source policy

When making or revising factual research claims, use sources in this order:

1. **Primary sources and project evidence**
   - published literature
   - datasets
   - completed analyses
2. **Project knowledge files**
   - checked summaries and claim modules in `knowledge/`
3. **Planning and process files**
   - useful for project history only, not for evidentiary support

If available evidence is incomplete or mixed, preserve that uncertainty rather than smoothing it away.

## Provenance requirements

When creating or materially revising substantive research content, preserve enough provenance for later review.

Important research notes should include:

```yaml
provenance:
  created: YYYY-MM-DD
  created_by: human | ai | mixed
  sources:
    - citation_or_path_here
  last_verified: YYYY-MM-DD
  verification_method: brief description
```

Use provenance to make claims recoverable: later readers should be able to identify what was asserted, what supports it, and when it was last checked.

## Rules for assistants

Assistants should:

- use real sources when making factual claims
- distinguish evidence, interpretation, and planning
- avoid inventing citations, results, analyses, or certainty
- keep edits focused on the requested task
- preserve the meaning of existing claims unless asked to revise them
- note uncertainty when the evidence does not justify a stronger statement
- update provenance when creating or materially changing research content

Assistants should not:

- cite planning documents or draft materials as evidence
- convert brainstorming into settled project knowledge
- silently strengthen, weaken, or redirect a claim
- make broad unrelated changes without a task-based reason

## Updating project knowledge

Add or revise durable project knowledge only when a claim is important enough to reuse later.

Reusable knowledge should include:

- a short claim statement
- supporting source(s) or analysis
- a status label such as `proposed`, `supported`, or `contested`
- provenance metadata

When a claim is still exploratory, keep it in notes or planning materials until it has been checked against evidence.

## Default workflow

For substantive research tasks:

```text
Check relevant sources and existing project knowledge
        ↓
Complete the requested work
        ↓
Verify important claims
        ↓
Update provenance or durable knowledge when warranted
```

The repository should remain easy to inspect, verify, and continue over time.
