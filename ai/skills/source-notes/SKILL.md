---
name: source-notes
description: Generate structured source notes from academic PDFs for knowledge management. Extracts key quotes, arguments, and connections to knowledge modules.
allowed-tools: Read, Write, Glob
---

# Source Notes Skill

## Purpose

This skill generates structured source notes from academic PDFs following a standardized template. It replaces the need for a `_TEMPLATE__source-notes.md` file in each project—the template is embedded in this skill.

## When to Use This Skill

Invoke this skill when:
- User types `/source-notes <path-to-pdf>` to create notes for a PDF
- User wants to extract quotes and key concepts from academic literature
- User needs to document a source for use in knowledge modules

## Embedded Template

The following is the canonical source notes template. Use this exact structure when generating source notes:

```markdown
---
type: source_notes
citation_key: AuthorYearFirstThreeWords    # Must match PDF filename (if exists)
source_type: article                       # book | article | chapter | report | thesis
pdf_available: true                        # true if CitationKey.pdf exists in this directory
access_method: pdf_in_repo                 # pdf_in_repo | physical_copy | library_access | unavailable
created: YYYY-MM-DD
last_read: YYYY-MM-DD
reader: <initials or name>
---

# Author (Year) - Short Title

## Bibliographic Information

<!--
If pdf_available: true, minimal info is fine (PDF is authoritative).
If pdf_available: false, include full bibliographic details here.
-->

Author, A. A., & Author, B. B. (Year). *Title of work*. Publisher.

- DOI/ISBN:
- BibTeX key: `AuthorYearFirstThreeWords`
- PDF: `AuthorYearFirstThreeWords.pdf` (if available)

---

## Summary

<!-- 2-3 paragraph overview of the source's main argument/contribution -->

---

## Key Sections

<!-- Organize by chapter, section, or theme as appropriate -->

### Section/Chapter Title (pp. X-Y)

**Main argument**: ...

**Key concepts**:
- Concept 1
- Concept 2

---

## Quotes

<!--
Quotes extracted for use as evidence in knowledge modules.
Use Q1, Q2, etc. for reference in the Connections table below.
-->

> **Q1 (p. X):** "Direct quote from the source..."

> **Q2 (pp. X-Y):** "Another quote..."

---

## Connections to Knowledge Modules

<!-- Track which quotes support which claims in which modules -->

| Quote ID | Supports Claim | Module | Notes |
|----------|---------------|--------|-------|
| Q1 | C1 | module-name | |
| Q2 | C3, C4 | module-name | |

---

## Critical Notes

<!--
Your analysis, questions, disagreements, connections to other sources.
This is where interpretation and synthesis happen.
-->

---

## Reading Log

<!-- Track reading sessions for verification purposes -->

| Date | Sections | Purpose |
|------|----------|---------|
| YYYY-MM-DD | Ch. 1-2 | Initial read for project X |
| YYYY-MM-DD | Ch. 4 | Focused read for claim Y |
```

## Operational Workflow

### Phase 1: Gather Information

**Step 1: Read the PDF**

Read the provided PDF file to extract content.

**Step 2: Determine output location**

Check if `sources/` directory exists. If so, write to `sources/{citation_key}.notes.md`. Otherwise, write to current directory.

### Phase 2: Extract Information

**Step 3: Identify bibliographic information**

Extract from the PDF:
- Author(s)
- Year of publication
- Title
- Journal/Publisher
- DOI if available
- Page range

**Step 4: Derive citation key**

Format: `AuthorYearFirstThreeWords`
- Use first author's last name
- Year of publication
- First three words of title (excluding articles a/an/the)
- Example: `Haig2005ExploratoryFactorAnalysis`

**Step 5: Write summary**

Create a 2-3 paragraph summary covering:
- Main thesis/argument of the work
- Key methodology or approach
- Primary contributions to the field
- Relevance to the user's research context (if known)

**Step 6: Identify key sections**

For each major section or chapter:
- Section title and page range
- Main argument
- Key concepts (bulleted list)

**Step 7: Extract quotes**

Select quotes that:
- Capture core arguments or definitions
- Provide evidence for potential claims
- Are citable (include exact page numbers)
- Use format: `> **Q# (p. X):** "Quote text..."`

Aim for 10-20 high-quality quotes for a typical article, more for books.

**Step 8: Map connections to knowledge modules**

If knowledge modules exist in the project (check for `knowledge/modules/`), identify which quotes could support which claims. Leave with placeholder entries if no modules exist.

**Step 9: Add critical notes**

Include:
- Relevance to the user's research
- Connections to other sources
- Limitations or questions
- Points of agreement/disagreement

### Phase 3: Write Output

**Step 10: Generate the source notes file**

Write to the determined location using the embedded template structure above.

## Quote Extraction Guidelines

### What Makes a Good Quote

1. **Definitional**: Defines key terms or concepts
2. **Argumentative**: States a core thesis or position
3. **Evidential**: Provides data or examples supporting claims
4. **Methodological**: Explains approach or reasoning
5. **Connective**: Links concepts or shows relationships

### Quote Formatting

```markdown
> **Q1 (p. 42):** "Direct quote with exact wording from the source."

> **Q2 (pp. 42-43):** "Quote spanning multiple pages..."

> **Q3 (p. 42, emphasis in original):** "Quote with *italics* in original."

> **Q4 (p. 42, emphasis added):** "Quote where I *added* emphasis."
```

### Page Number Handling

- Single page: `(p. 42)`
- Page range: `(pp. 42-43)`
- No page numbers (web): `(para. 3)` or `(section: Title)`
- PDF page vs print page: Note if different

## Special Handling

### Books vs Articles

**Articles**: Usually 10-20 quotes covering main argument
**Books**:
- Create section-by-section breakdown
- 20-40 quotes across key chapters
- Note chapters not relevant to current research

### Sources Without PDFs

If `pdf_available: false`:
- Include complete bibliographic information
- Note how source was accessed
- Be explicit about which sections were read

### Non-English Sources

- Include original language quotes if relevant
- Provide translations in brackets
- Note translator if using published translation

## Integration with Knowledge Modules

Source notes serve as the evidence layer for knowledge modules:

```
Primary Literature (PDFs)
         ↓
Source Notes (quotes with page numbers)
         ↓
Knowledge Modules (claims with evidence pointers)
         ↓
Manuscripts (citations)
```

### Evidence Chain

When a knowledge module claim cites evidence:
1. The claim points to a source note quote ID
2. The source note provides the exact quote and page
3. The PDF provides authoritative verification

## Error Handling

**PDF not readable:**
```
Unable to read PDF content. Please verify:
- File exists at specified path
- File is not corrupted
- File is not password-protected
```

**No sources directory:**
```
No sources/ directory found. Creating source notes in current directory.
Consider creating sources/ for organized literature management.
```

## Token Efficiency

This skill eliminates the need for:
- Reading a template file from each project (~90 tokens saved)
- Negotiating output format
- Multiple round-trips to clarify structure

The embedded template ensures consistent output across all projects while the skill handles all formatting details.
