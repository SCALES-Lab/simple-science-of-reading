---
type: knowledge_index
status: active
created: 2026-05-15
provenance:
  created: 2026-05-15
  created_by: ai
  sources:
    - knowledge/modules/README.md
    - knowledge/modules/svr-dd-theoretical-foundations.md
  last_verified: 2026-05-15
  verification_method: "Inspected the current knowledge/ directory and indexed only durable knowledge files present in the repository."
---

# Knowledge Index

This directory contains the project’s **durable knowledge layer**: claims and theoretical modules that are meant to remain inspectable, reusable, and distinct from planning records or draft work.

## Operating Principle

> Durable project knowledge belongs here only when it is grounded in evidence and carries enough provenance for later review.

Planning files, decision notes, draft manuscripts, and prior assistant outputs may help explain project history, but they are **not** evidence for research claims.

## Current Knowledge Modules

| Module | Type | Topic | Claim Status | Last Verified | Notes |
|---|---|---|---|---|---|
| [`modules/svr-dd-theoretical-foundations.md`](modules/svr-dd-theoretical-foundations.md) | theoretical module | SVR-DD model specification | proposed | 2026-04-02 | Extends the Simple View of Reading with explicit developmental dynamics; several developmental claims remain to be empirically validated. |

## Directory Map

```text
knowledge/
├── INDEX.md
├── claims/
│   └── INDEX.md
└── modules/
    ├── README.md
    └── svr-dd-theoretical-foundations.md
```

## Status Summary

- **Active modules:** 1
- **Established modules:** 0
- **Proposed modules:** 1
- **Contested modules:** 0
- **Superseded modules:** 0

## Integrity Notes

- The current module includes a provenance block, claim ledger, evidence snippets, references, and a supersession ledger.
- Some evidence pointers in the module refer to source materials or source-note paths that are not yet present in the current repository layout; those should be resolved before treating the module as fully hardened project knowledge.
- `knowledge/claims/INDEX.md` now serves as the project-wide claim registry and should be updated whenever module-level claims change materially.

## When to Update This Index

Update this file when:

1. a new durable knowledge module is added;
2. a module changes status (`proposed`, `accepted`, `established`, `contested`, `deprecated`, or `superseded`);
3. a module is superseded or removed from active use; or
4. the directory structure for durable knowledge changes materially.

## Relationship to Other Project Materials

| Material | Role | Evidentiary Status |
|---|---|---|
| `sources/`, `data/`, completed analyses | Primary evidence | May support claims |
| `knowledge/` | Checked project knowledge | May summarize supported claims |
| `ai/`, drafts, planning files | Process history | Not evidence |
