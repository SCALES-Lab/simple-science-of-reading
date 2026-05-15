# Knowledge Modules (`knowledge/modules`)

## Purpose

This directory contains **durable knowledge modules**: authoritative theoretical content developed in the SOL-SOR Grade-Level Variation project. These are distinct from decision memos (task directives) in `ai/decisions/`.

## Core Principle

> **Knowledge modules are authoritative. Decision memos are not.**

This distinction prevents abstraction degradation through task-as-knowledge confusion.

---

## Directory Structure

```
knowledge/
├── INDEX.md              # Module registry (entry point)
├── README.md             # This file
├── modules/              # Durable theoretical modules
│   ├── _TEMPLATE__knowledge-module.md
│   └── *.md              # Individual modules (created as research progresses)
└── claims/               # Central claim tracking
    └── INDEX.md          # Project-wide claim ledger
```

---

## What Knowledge Modules Are

### ARE

- **Authoritative knowledge** about reading development developed in this project
- **Durable content** that persists beyond specific tasks
- **Evidence-backed claims** with provenance from reading science literature
- **Preparatory work** for eventual AIKB integration

### ARE NOT

- Task directives (those go in `ai/decisions/`)
- Ephemeral notes or brainstorming
- Content without provenance or evidence
- Research planning documents (those go in `project-management/planning/`)

---

## Required Metadata

Every knowledge module must include:

### 1. YAML Provenance Block

```yaml
provenance:
  conversation_date: YYYY-MM-DD
  conversation_id: <identifier>
  primary_sources:
    - citation_key: AuthorYearFirstThreeWords
      role: foundational_framework
      pdf: sources/AuthorYearFirstThreeWords.pdf
      notes: sources/AuthorYearFirstThreeWords.notes.md
  claim_status: proposed | established | contested
  last_verified: YYYY-MM-DD
  verification_method: "<description>"
  verified_by: "<who>"
```

### 2. Claim Ledger (5-12 claims)

```markdown
## Claim Ledger

| ID | Claim | Scope | Evidence | Status | Notes |
|----|-------|-------|----------|--------|-------|
| C1 | Atomic, testable claim about reading development | Grade levels, skills | source#location | proposed | |
```

### 3. Evidence Snippets (2-6 quotes)

```markdown
## Evidence Snippets

> **E1 (AuthorYearFirstThreeWords, p. X):** "Direct quote supporting claims..."
> See: sources/AuthorYearFirstThreeWords.notes.md#Q1
```

---

## Operational Mode

This project operates in **Source Project Development Mode**:

- This project is authoritative for its own knowledge claims about reading development
- Provenance must point to reading science literature/data sources (not AIKB)
- Goal is preparing knowledge for eventual AIKB integration
- Focus on reading development theories (SVR-DD, constrained/unconstrained skills, etc.)

---

## How AI Assistants Must Use This Directory

### When Reading

1. Check `INDEX.md` for available modules
2. Trust module content as authoritative (within stated claim status)
3. Note `last_verified` dates for stale content

### When Writing

1. Use `_TEMPLATE__knowledge-module.md` for new modules
2. Include all required metadata (provenance, claims, evidence)
3. Update `INDEX.md` when adding/modifying modules
4. Update `claims/INDEX.md` with new claims
5. Never cite decision memos or planning documents as evidence
6. Only extract from AUTHORITATIVE sources:
   - Published literature in `sources/`
   - Complete, authoritative manuscripts (marked explicitly)
   - Empirical data analyses (ECLS-K results)

### When Integrating to AIKB

1. Verify all claims have evidence snippets
2. Confirm provenance points to reading science literature
3. Check for superseded terminology
4. Follow AIKB integration workflow

---

## Validation Checklist

Before considering a module complete:

- [ ] YAML provenance block with all required fields
- [ ] `last_verified` and `verification_method` specified
- [ ] Claim ledger with 5-12 atomic, testable claims about reading development
- [ ] Evidence snippets with 2-6 exact quotes and locations from reading science
- [ ] References section with full citations
- [ ] Module registered in `INDEX.md`
- [ ] Claims registered in `claims/INDEX.md`
- [ ] No decision memos or planning documents cited as evidence

---

## Relationship to Decision Memos and Planning

| Aspect | Knowledge Modules | Decision Memos | Planning Documents |
|--------|-------------------|----------------|-------------------|
| Location | `knowledge/` | `ai/decisions/` | `project-management/planning/` |
| Purpose | What is true about reading | What to do next | Strategic direction |
| Authority | Authoritative | Not authoritative | Not authoritative |
| Lifespan | Durable | Archived after implementation | Versioned, archived |
| Evidence | Required | Not a source | Not a source |

---

## Status Progression

```
proposed → accepted → established → deprecated
    ↓                      ↓
contested              superseded
```

- **Proposed**: Derived from reading science sources, not yet validated
- **Accepted**: Consistent with sources on spot-check
- **Established**: Multiple independent sources, reviewed
- **Contested**: Conflicting evidence or interpretations
- **Deprecated**: No longer maintained
- **Superseded**: Replaced by newer module

---

## Module Creation Guidelines for This Project

As the SOL-SOR project progresses, knowledge modules should be created for:

1. **Theoretical Frameworks**:
   - SVR-DD (Simple View of Reading with Developmental Dynamics)
   - Constrained vs. unconstrained skills framework
   - Mutualism model applied to reading development
   - Competing reading theories (Reading Rope, Lexical Quality, Ehri, DRC)

2. **Empirical Phenomena**:
   - Phenomenon signatures P1-P7 (once reliabilistically established)
   - Grade-level effect patterns from meta-analysis
   - ECLS-K growth trajectories and patterns

3. **Methodological Knowledge**:
   - Pattern-oriented validation for reading models
   - Phenomenon detection protocols specific to reading
   - Calibration standards for reading development models

**Timing**: Modules should be created when:
- Literature review identifies stable, well-supported claims
- Meta-analysis establishes robust phenomena
- ECLS-K analysis produces validated empirical patterns
- Simulation models are validated and produce theoretical insights

**NOT before**:
- Preliminary exploration
- Draft manuscripts (unless marked AUTHORITATIVE)
- Task planning (belongs in `project-management/planning/`)
