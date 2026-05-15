---
name: knowledge-integrity
description: Maintains knowledge integrity across task-driven workflows by enforcing provenance tracking, claim ledgers, evidence requirements, source notes, and knowledge-task separation. Use when implementing decision memos, integrating knowledge from source projects, validating knowledge modules, creating source notes for literature, checking for superseded terminology, or ensuring task artifacts are not treated as authoritative knowledge sources.
allowed-tools: Read, Grep, Glob, Edit, Write, Bash
---

# Knowledge Integrity Skill

## Critical Principle

**Decision memos and task artifacts are NEVER authoritative knowledge sources.**

This Skill enforces the distinction between:
- **Knowledge** (what is true) - lives in `.qmd` modules with provenance
- **Tasks** (what to do) - lives in `ai/decisions/` memos without knowledge authority

## Core Failure Mode This Prevents

**Abstraction degradation through task-as-knowledge confusion:**
- Task artifacts (decision memos, planning docs) cited as evidence for claims
- Temporal documents supplanting durable knowledge modules
- Lost provenance chains from original sources to integrated knowledge
- Superseded terminology lingering when newer terms are adopted

## Operational Modes

This Skill operates in two distinct modes based on context:

### Mode 1: AIKB Integration Mode

**Context**: Working in the AIKB repository to integrate knowledge FROM registered projects

**Authority model**: External source projects are authoritative

**Key operations**:
- Read `projects_registry.yml` to identify registered source projects
- Validate provenance paths point to registered project artifacts
- Track supersessions when source terminology differs from AIKB content
- Enforce `requires_evidence: true` for knowledge claim changes
- Update `last_reviewed` dates in registry after integration

**Provenance requirement**: MANDATORY - must point to source project artifacts

**Files to check**:
- `ai/decisions/INDEX.md` - Decision memo queue
- `projects_registry.yml` - Registered source projects
- Target `.qmd` modules in: `foundations/`, `methods/`, `gtc/`, `education_systems/`, etc.

### Mode 2: Source Project Development Mode

**Context**: Working in a source project (e.g., `/extending-explanatory-coherence/`) to develop new knowledge

**Authority model**: THIS project is authoritative (but must cite literature/data)

**Key operations**:
- Track evolution of project's own knowledge claims
- Maintain provenance to literature/data sources
- Build claim ledgers as theoretical work progresses
- Prepare knowledge for eventual AIKB integration

**Provenance requirement**: Evidence from literature, data, or simulation outputs

**Files to check**:
- Project-specific decision memos (if `ai/decisions/` exists)
- Manuscripts, analysis scripts, data files
- Project documentation

## Sub-Skill Orchestration

Knowledge-integrity delegates to specialized sub-skills for focused operations. Use explicit skill invocation when the task matches a sub-skill's purpose.

### When to Invoke /source-notes

Delegate to `/source-notes` when:

- User requests: `/source-notes <path-to-pdf>`
- Creating source notes for new literature
- Evidence snippet references source that lacks notes file
- Building provenance chain for knowledge module

**Do not delegate** general PDF reading—only structured note extraction.

### When to Invoke /decision-notes

Delegate to `/decision-notes` when:

- Creating a new decision memo
- Implementing the lifecycle (accept → implement → archive)
- Updating INDEX.md queue status
- Managing grounding status tracking

**Do not delegate** the actual knowledge module changes—those are direct handling.

### When to Invoke /project-assess

Delegate to `/project-assess` when:

- First encounter with a new project
- User requests compliance check
- After major structural reorganization
- Before AIKB integration work

### Direct Handling (No Delegation)

Handle directly without sub-skill invocation:

- Provenance block validation in existing modules
- Claim ledger verification and updates
- Evidence snippet completeness checks
- Supersession tracking across modules
- AIKB integration mode operations
- Cross-module consistency verification

## Source Notes Layer

Source notes bridge raw sources (PDFs, books) and knowledge module claims. They document reading, extract quotes, and track how sources support specific claims.

### File Convention

```
resources/
├── CitationKey.pdf           # PDF if available
├── CitationKey.notes.md      # Reading notes, quotes, summaries
```

### Citation Key Format

`LastNameYearFirstThreeWords`

Examples:
- `Machamer2000ThinkingAboutMechanisms.pdf` + `.notes.md`
- `Craver2007ExplainingTheBrain.notes.md` (book, no PDF)
- `CraverDarden2013InSearchMechanisms.notes.md`

### Provenance Chain

```
Module claim (C4)
  → Evidence snippet (E3)
    → Source notes quote (Q1)
      → Physical source (p. 113)
```

### Source Notes YAML Schema

```yaml
type: source_notes
citation_key: Craver2007ExplainingTheBrain
source_type: book              # book | article | chapter | report
pdf_available: false           # true if CitationKey.pdf exists
access_method: physical_copy   # pdf_in_repo | physical_copy | library_access | unavailable
created: YYYY-MM-DD
last_read: YYYY-MM-DD
reader: <initials>
```

### Source Notes Structure

```markdown
# Author (Year) - Short Title

## Bibliographic Information
[Full citation; required if no PDF]

## Summary
[2-3 paragraph overview]

## Key Sections
### Chapter/Section (pp. X-Y)
[Main argument, key concepts]

## Quotes
> **Q1 (p. X):** "Direct quote..."
> **Q2 (p. Y):** "Another quote..."

## Connections to Knowledge Modules
| Quote ID | Supports Claim | Module | Notes |
|----------|---------------|--------|-------|
| Q1 | C4 | cognitive-bottomout-activities | |

## Critical Notes
[Analysis, questions, connections]

## Reading Log
| Date | Sections | Purpose |
```

### When to Create Source Notes

- **Before** citing a new source in a knowledge module
- When reading a source for project purposes
- To document books/sources without available PDFs
- When extracting quotes for evidence snippets

### Linking Pattern

In knowledge modules, evidence snippets reference source notes:

```markdown
> **E3 (Craver, 2007, p. 113):** "A mechanism schema is..."
> See: resources/Craver2007ExplainingTheBrain.notes.md#Q1
```

The source notes quote (Q1) contains the same text with full context.

## When to Invoke This Skill

Invoke this Skill when:

1. **Implementing decision memos** - Especially those with `requires_evidence: true`
2. **Integrating from source projects** - Knowledge flowing from registered projects into AIKB
3. **Detecting supersession conflicts** - Old terminology needs systematic replacement
4. **Validating knowledge modules** - Checking provenance and claim ledgers are complete
5. **Preventing task-as-knowledge errors** - Someone cites a decision memo as a knowledge source
6. **Creating or validating source notes** - Ensuring provenance chain is complete

## Standard Workflow: Implementing Decision Memos

### Phase 1: Preparation

**Step 1: Read the queue**
```bash
cat ai/decisions/INDEX.md
```
Identify memos with `status: accepted`.

**Step 2: Read target memo**
```bash
cat ai/decisions/YYYY-MM-DD__topic__slug.md
```

**Step 3: Determine operational mode**
- Check memo YAML for `mode: aikb_integration` or `mode: source_development`
- If AIKB mode: validate `source_project` exists in `projects_registry.yml`
- If source mode: validate evidence sources exist

**Step 4: Validate scope**
- Confirm `targets:` list is complete
- Check `requires_evidence: true` if knowledge claims change
- Review `supersession_tracking: true` if terminology conflicts expected

### Phase 2: Implementation

**Step 5: Read all target files**
- Understand existing structure before changes
- Identify where provenance/claim ledgers need updates

**Step 6: Apply changes with integrity protections**

For each target file that changes knowledge claims:

**a) Add/update YAML provenance block:**

```yaml
provenance:
  primary_sources:
    # Source with PDF available
    - citation_key: Machamer2000ThinkingAboutMechanisms
      role: foundational_framework
      pdf: resources/Machamer2000ThinkingAboutMechanisms.pdf
      notes: resources/Machamer2000ThinkingAboutMechanisms.notes.md
    # Source without PDF (book)
    - citation_key: Craver2007ExplainingTheBrain
      role: supporting
      notes: resources/Craver2007ExplainingTheBrain.notes.md
  claim_status: proposed          # proposed | established | contested
  last_verified: YYYY-MM-DD
  verification_method: "spot-check against source X; systematic review of Y"
  verified_by: "<who verified>"
```

**b) Add/update Claim ledger section:**
```markdown
## Claim ledger

| ID | Claim (atomic, testable) | Scope / conditions | Evidence pointer(s) | Status | Notes |
| ---: | --- | --- | --- | --- | --- |
| C1 | Specific claim statement | Where it applies | #section; file.qmd:123 | confirmed | Any qualifications |
| C2 | Another claim | Scope | #anchor; external-source | tentative | Needs validation |
```

**Target**: 5-12 claims per module (atomic, testable, scoped)

**c) Add/update Evidence snippets section:**

```markdown
## Evidence snippets

> **E1 (Machamer et al., 2000, p. 13):** "Direct quote from authoritative source..."
> See: resources/Machamer2000ThinkingAboutMechanisms.notes.md#Q1

> **E2 (Craver, 2007, p. 113):** "Another excerpt with precise provenance..."
> See: resources/Craver2007ExplainingTheBrain.notes.md#Q1
```

**Target**: 2-6 snippets per module (exact quotes, precise locations)

**Note**: Evidence snippets link to source notes quotes (Q1, Q2) which contain the same text with full context.

**Step 7: Supersession tracking (if applicable)**

If memo specifies `supersession_tracking: true`:

1. Search codebase for OLD terminology:
```bash
grep -r "old-term" gtc/ foundations/ methods/
```

2. Create supersession ledger in affected modules:
```markdown
## Supersession ledger

| Date | Old term | New term | Rationale | Source |
| --- | --- | --- | --- | --- |
| YYYY-MM-DD | old-terminology | new-terminology | Why supersession needed | authoritative-source-file.md |
```

3. Systematically replace old with new (preserve exact meaning)

4. Verify complete: search again for OLD terminology, expect zero results

### Phase 3: Commit Implementation

**Step 8: Create implementation commit**
```bash
git add ai/decisions/YYYY-MM-DD__topic__slug.md
git add <modified-files>

git commit -m "feat(<area>): implement <topic>

<Description of changes>
- Component 1: what changed
- Component 2: what changed

<Statistics>
- X claims added/updated
- Y evidence snippets added
- Z files modified

Implements: ai/decisions/YYYY-MM-DD__topic__slug.md

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
"
```

**Step 9: Record commit hash** (e.g., `7c7afa4`)

### Phase 4: Close Out

**Step 10: Update memo YAML**
```yaml
status: implemented  # was: accepted
implementation:
  commit: "7c7afa4"
  implemented_by: "Claude Sonnet 4.5"
  implemented_on: "YYYY-MM-DD"
```

**Step 11: Update INDEX.md**
Move memo from "Active Queue" to "Implemented / Closed"

**Step 12: Archive memo**
```bash
git mv ai/decisions/YYYY-MM-DD__topic__slug.md ai/decisions/archive/
```

**Step 13: Commit closeout**
```bash
git add ai/decisions/INDEX.md
git add ai/decisions/archive/YYYY-MM-DD__topic__slug.md

git commit -m "docs(decisions): close out <topic> memo

- Update INDEX.md with commit <hash>
- Set memo status to implemented
- Move memo to archive/
- Record implementation by <who> on <date>

Implementation complete: <summary>

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
"
```

**Step 14: Update projects_registry.yml (if AIKB integration)**
```yaml
projects:
  - path: "/path/to/source/project"
    last_reviewed: "YYYY-MM-DD"  # TODAY
    # ... other fields
```

## Validation Checklist

Before marking a decision memo as implemented, verify:

### Knowledge Integrity Checks

- [ ] All knowledge claim changes have provenance blocks
- [ ] Provenance uses `citation_key` + `notes` format
- [ ] Claim ledgers contain 5-12 atomic, testable claims
- [ ] Evidence snippets provide 2-6 exact quotes with locations
- [ ] Evidence snippets link to source notes quotes (E1 → Q1)
- [ ] No decision memos or task files cited as knowledge sources
- [ ] Superseded terminology systematically replaced (if applicable)
- [ ] Source project files exist at specified absolute paths (AIKB mode)

### Source Notes Checks

- [ ] Each cited source has a `CitationKey.notes.md` file in `resources/`
- [ ] Source notes have complete YAML metadata (citation_key, source_type, pdf_available)
- [ ] Source notes contain extracted quotes (Q1, Q2) matching evidence snippets
- [ ] Connections table links quotes to module claims
- [ ] For books without PDFs: full bibliographic info in notes

### Decision Memo Checks

- [ ] Memo has correct YAML metadata (type, status, created, targets, etc.)
- [ ] Implementation section filled: commit hash, implemented_by, implemented_on
- [ ] INDEX.md updated: memo moved to "Implemented / Closed"
- [ ] Memo file moved to `ai/decisions/archive/`
- [ ] Both commits made: implementation + closeout

### Project Registry Checks (AIKB mode only)

- [ ] `last_reviewed` date updated in `projects_registry.yml`
- [ ] `aikb_outputs` list includes modified files
- [ ] Source project path still valid

### Content Quality Checks

- [ ] Markdown headings used (NOT bold as headings)
- [ ] Blank lines before lists
- [ ] Citation keys follow convention: `LastNameYearFirstThreeWords`
- [ ] YAML front matter complete: title, tags, updated, summary
- [ ] Site preview confirms no broken links

## Anti-Drift Principles

**Enforce these rules strictly:**

1. **Bounded scope**: Edit ONLY files listed in memo `targets:`
2. **No cleanup**: Don't "improve" unrelated code or content
3. **Small diffs**: Prefer incremental, focused changes
4. **Memos are not evidence**: Decision memos NEVER cited as knowledge sources
5. **Update durable modules**: Changes flow into `.qmd` modules, not stay in memos
6. **Preserve exact terminology**: When integrating, use source project's exact language
7. **Track supersessions explicitly**: Old terms don't "fade away" - they're systematically replaced

## Integration with AIKB Workflows

This Skill complements existing AIKB update approaches:

### Decision Memo Pipeline (This Skill)
- Small, bounded, auditable changes
- Explicit provenance and claim tracking
- High integrity, low drift
- Time-ordered record of intent

### Broad Content Creation
- New modules and exploratory content
- Periodic chat log imports
- Lower formality, more experimentation

**Use decision memo pipeline when**: Knowledge claims change, provenance critical, supersessions needed

**Use broad creation when**: New exploratory content, brainstorming, initial drafts

## Common Operations

### Initialize decision memo infrastructure in a project

```bash
mkdir -p ai/decisions/archive
cp <aikb-path>/ai/decisions/_TEMPLATE__decision-memo.md ai/decisions/
# Adapt INDEX.md and README.md from AIKB template
```

### Check for superseded terminology

```bash
grep -r "old-terminology" gtc/ foundations/ methods/
# Should return zero results if supersession complete
```

### Validate provenance completeness

```bash
# Find .qmd files missing provenance blocks
grep -L "^provenance:" gtc/*.qmd foundations/*.qmd
```

### Verify claim ledgers exist

```bash
# Find .qmd files missing claim ledgers
grep -L "## Claim ledger" gtc/*.qmd foundations/*.qmd
```

### Initialize source notes infrastructure

```bash
# Create template in resources/
cp <project-path>/resources/_TEMPLATE__source-notes.md resources/
```

### Create source notes for a new source

```bash
# Copy template with citation key name
cp resources/_TEMPLATE__source-notes.md resources/AuthorYearFirstThreeWords.notes.md
# Edit to fill in bibliographic info, quotes, connections
```

### Check for missing source notes

```bash
# List PDFs without corresponding notes files
for pdf in resources/*.pdf; do
  notes="${pdf%.pdf}.notes.md"
  [ ! -f "$notes" ] && echo "Missing: $notes"
done
```

### Validate source notes completeness

```bash
# Find notes files missing required sections
grep -L "## Quotes" resources/*.notes.md
grep -L "## Connections to Knowledge Modules" resources/*.notes.md
```

## File Paths and Locations

### AIKB Key Paths

- Decision memos: `ai/decisions/`
- Decision queue: `ai/decisions/INDEX.md`
- Workflow docs: `ai/decisions/README.md`, `workflows/decision-memo-workflow.qmd`
- Project registry: `projects_registry.yml`
- Knowledge modules: `foundations/`, `methods/`, `gtc/`, `education_systems/`, `cognition_growth/`, `leadership/`

### Prototypical Project Key Paths

These paths reflect the standardized project structure:

- Knowledge modules: `knowledge/modules/`
- Knowledge index: `knowledge/INDEX.md`
- Claims ledger: `knowledge/claims/INDEX.md`
- Provenance audits: `knowledge/audits/`
- Decision memos: `ai/decisions/`
- Decision queue: `ai/decisions/INDEX.md`
- Source PDFs: `sources/*.pdf`
- Source notes: `sources/*.notes.md`
- Assistant context: `ai/assistant-context/`
- Strategic planning: `project-management/planning/`

**Note**: Older projects may use `ai/knowledge/` instead of `knowledge/`, or `resources/` instead of `sources/`. The `/project-assess` skill can identify and recommend migration.

### Source Notes File Convention

```
resources/
├── _TEMPLATE__source-notes.md              # Template
├── AuthorYearFirstThreeWords.pdf           # PDF (if available)
├── AuthorYearFirstThreeWords.notes.md      # Reading notes (always)
```

Citation key format: `LastNameYearFirstThreeWords`

Examples:
- `Machamer2000ThinkingAboutMechanisms`
- `Craver2007ExplainingTheBrain`
- `CraverDarden2013InSearchMechanisms`

### Decision Memo YAML Schema

Required fields:
```yaml
type: decision_memo
status: proposed|accepted|implemented|superseded|abandoned
created: YYYY-MM-DD
source: chatgpt_web|claude_web|human|mixed
topic: topic_slug
targets:
  - path: relative/path/to/file.qmd
    change_type: edit|create|delete
requires_evidence: true|false
implementation:
  commit: ""
  implemented_by: ""
  implemented_on: ""
supersedes: []
superseded_by: []
```

Optional AIKB-specific fields:
```yaml
mode: aikb_integration
source_project: "project-name"  # must match projects_registry.yml
requires_provenance: true
supersession_tracking: true
authoritative_sources:
  - /absolute/path/to/source/file
```

## Error Patterns to Detect

### Task-as-Knowledge Errors

**Symptom**: Provenance block references a decision memo as a source
```yaml
provenance:
  sources:
    - ai/decisions/2026-01-08__topic.md  # ❌ WRONG - memos are not knowledge
```

**Fix**: Replace with actual source artifact
```yaml
provenance:
  sources:
    - /path/to/source/project/manuscript.qmd  # ✓ CORRECT - authoritative source
```

### Incomplete Supersession

**Symptom**: Old terminology still found after "complete" supersession
```bash
grep -r "Performative Coherence" gtc/  # Returns matches ❌
```

**Fix**: Systematic replacement
1. Find all instances
2. Replace with new term
3. Update supersession ledger
4. Verify zero results

### Missing Provenance

**Symptom**: Knowledge module lacks provenance metadata
```markdown
# No YAML provenance block
# No claim ledger
# No evidence snippets
```

**Fix**: Add complete integrity metadata per template above

### Drift Through Enhancement

**Symptom**: Implementation adds content beyond memo targets
- "Improved" formatting in unrelated files
- Added "helpful" comments to other modules
- "Cleaned up" code not in scope

**Fix**: Revert changes outside bounded scope; stay strictly within targets

## Progressive Disclosure

For detailed reference:
- [Decision Memo Workflow](../../../workflows/decision-memo-workflow.qmd)
- [Complete Implementation Guide](../../../ai/decisions/README.md)
- [CLAUDE.md Project Instructions](../../../CLAUDE.md)
- [Citation Conventions](../../../reference/citation_keys.qmd)

## Example Invocations

**Check decision memo integrity:**
```
Review ai/decisions/2026-01-10__gtc-integration__recent-developments.md for integrity
```

**Implement accepted memo:**
```
Implement the accepted GTC integration decision memo with full knowledge integrity checks
```

**Validate knowledge module:**
```
Check if gtc/tripartite-architecture.qmd has complete provenance and claim ledger
```

**Verify supersession complete:**
```
Confirm all instances of "old-terminology" replaced with "new-terminology" in target directories
```

**Integrate from source project:**
```
Integrate recent developments from extending-explanatory-coherence project into AIKB with provenance
```
