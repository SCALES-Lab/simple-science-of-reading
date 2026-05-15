---
type: claim_index
status: active
created: 2026-05-15
provenance:
  created: 2026-05-15
  created_by: ai
  sources:
    - knowledge/modules/svr-dd-theoretical-foundations.md
    - knowledge/INDEX.md
  last_verified: 2026-05-15
  verification_method: "Transcribed the current claim ledger from knowledge/modules/svr-dd-theoretical-foundations.md and checked claim statuses against the module metadata."
---

# Claim Index

This file is the project-wide registry of durable claims currently represented in `knowledge/`. It is an index, not an independent evidence source: each claim remains grounded in its originating module and the primary sources or analyses cited there.

## Status Summary

| Status | Count |
|---|---:|
| established | 1 |
| proposed | 10 |
| accepted | 0 |
| contested | 0 |
| deprecated | 0 |
| superseded | 0 |

## Current Claims

| Claim ID | Claim | Scope / Conditions | Originating Module | Evidence Pointer(s) | Status | Notes |
|---|---|---|---|---|---|---|
| SVR-DD-C1 | Reading comprehension = Decoding × Language Comprehension (SVR) | Measurement model, single time point | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | Hoover1990; Gough1986 | established | Original SVR |
| SVR-DD-C2 | Decoding exhibits constrained logistic growth to carrying capacity K_D due to automaticity | K-5 reading development | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | Paris2005; LaBerge1974; vanGeert1991 Q4-Q6, Q8-Q9; Part III | proposed | SVR-DD extension; logistic rather than exponential |
| SVR-DD-C3 | Language comprehension exhibits high-K logistic growth that approximates linear within K-5 | K-5 and beyond | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | Paris2005; Perfetti2007; vanGeert1991 Q2, Q4; Part III | proposed | Refined: not purely linear but logistic with K_L far above attainable level |
| SVR-DD-C4 | Decoding growth rate is highest at mid-development and near zero as decoding approaches carrying capacity | Early reading development | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | vanGeert1991 Q9; Prediction 1 | proposed | Testable via ECLS-K phenomenon signature P1 |
| SVR-DD-C5 | Language comprehension growth rate remains positive across all grades | K-5 reading development | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | Prediction 2 | proposed | Testable via ECLS-K phenomenon signature P2 |
| SVR-DD-C6 | SoR decoding interventions are most effective in early grades when decoding is limiting | Instructional timing effects | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | Prediction 3 | proposed | Testable via meta-analysis phenomenon signature P4 |
| SVR-DD-C7 | Decoding-language comprehension correlation increases from early to later grades due to variance shift and mutualism | Longitudinal correlation patterns | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | vanGeert1991 Q10; Prediction 4 | proposed | Testable via ECLS-K phenomenon signature P3 |
| SVR-DD-C8 | SVR-DD with constrained decoding and unconstrained language comprehension generates grade-level variation in instruction effects | Theoretical sufficiency | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | Part IV; computational model | proposed | Model comparison needed |
| SVR-DD-C9 | Both decoding and language comprehension grow via autocatalytic logistic dynamics under limited resources | General cognitive growth | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | vanGeert1991 Q1, Q8; Part II | proposed | Constrained vs. unconstrained = different carrying capacities, same growth form |
| SVR-DD-C10 | Carrying capacity for decoding may be dynamic and adapt to instructional environment | SoR vs. control conditions | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | vanGeert1991 Q11; Part III | proposed | Instruction may change K_D, not only r_D |
| SVR-DD-C11 | Apparent stage-like transition from decoding-limited to language-limited reading emerges from continuous logistic dynamics | K-2 to grades 3-5 transition | [`svr-dd-theoretical-foundations`](../modules/svr-dd-theoretical-foundations.md) | vanGeert1991 Q13; Part III | proposed | No discrete structural change required |

## Claim-ID Convention

Use the pattern:

```text
<MODULE-SLUG>-C<number>
```

Example: `SVR-DD-C4`

The module-local claim ID may remain `C4` inside its source module, but the project-wide index should use a namespaced ID so claims remain unique as the knowledge base grows.

## Integrity Notes

- Only `SVR-DD-C1` is currently marked **established**.
- Claims `SVR-DD-C2` through `SVR-DD-C11` remain **proposed** and should not be treated as settled project knowledge until their evidence chains and empirical tests are stronger.
- Several evidence pointers in the originating module still rely on source materials or source-note paths that do not match the repository’s current layout; resolve those provenance gaps before promoting claims.

## Update Rules

Update this index whenever:

1. a knowledge module adds, removes, or materially revises a claim;
2. a claim status changes;
3. a claim is superseded, deprecated, or contested; or
4. a new module introduces project-wide claims that require namespaced IDs.
