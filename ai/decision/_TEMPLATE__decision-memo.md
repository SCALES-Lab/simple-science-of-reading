---
type: decision_memo
status: proposed              # proposed | accepted | implemented | superseded | abandoned
created: YYYY-MM-DD
source: claude_web            # claude_web | chatgpt_web | human | mixed
topic: <short_topic_tag>      # e.g., simulation_development, eclsk_analysis, gtc_integration
targets:
  - path: <repo-relative-path>
    change_type: edit         # edit | add | move | delete
requires_evidence: false      # true if this changes knowledge claims about reading development
implementation:
  commit: ""
  implemented_by: ""
  implemented_on: ""
supersedes: []
superseded_by: []
---

# Decision memo: <short title>

## Context

- What problem or opportunity triggered this memo?
- What is the failure mode (e.g., drift, clutter, ambiguity, regressions)?
- How does this relate to the SOL-SOR research goals?

## Decision

State the decision precisely, in implementable terms.

## Constraints (anti-drift)

- This memo is **not evidence** about reading development.
- If knowledge claims change, update durable modules in `ai/knowledge/` with provenance + claim ledger.
- Keep diffs small and bounded to targets listed below.
- Do not extract knowledge from decision memos—only from authoritative sources.

## Targets

List specific files/directories to change.

- `<path>` — <what changes and why>
- `<path>` — <what changes and why>

## Implementation plan

1. Step 1
2. Step 2
3. Step 3

## Evidence requirements (only if requires_evidence: true)

- Identify the source artifacts to anchor claim changes:
  - Reading science literature: `sources/<CitationKey>.pdf` and `sources/<CitationKey>.notes.md`
  - Empirical data: ECLS-K analyses, meta-analysis results
  - Authoritative manuscripts (marked explicitly)
- Specify minimum verification method (e.g., "spot-check 3 key claims against Paris 2005").

## Acceptance criteria (definition of done)

- [ ] Target files updated as specified
- [ ] If claims changed: provenance updated + claim ledger updated + evidence pointers added in `ai/knowledge/`
- [ ] `ai/decisions/INDEX.md` updated
- [ ] Commit hash recorded in this memo
- [ ] Memo moved to `ai/decisions/archive/` and status set to implemented (or abandoned)
- [ ] Quarto preview/render still works

## Risks / rollback

- What could go wrong?
- How to revert (e.g., "git revert <commit>")?

## Notes

Anything else that helps future interpretation.
