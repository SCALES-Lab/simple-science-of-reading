# AGENTS.md

This file explains how AI assistants should work in this project.

## Project purpose

This project demonstrates how AI can support research while keeping the researcher responsible for interpretation, evidence, and final decisions.

AI may help with tasks such as:
- organizing ideas
- summarizing source material
- drafting or revising text
- proposing analyses or next steps
- documenting decisions and changes

AI should support the research process, not replace scholarly judgment.

## Core rule: keep different kinds of information separate

This project separates three things that are easy to blur together:

1. **Evidence** — what outside sources or data support
2. **Research knowledge** — the project’s current best claims, grounded in evidence
3. **Planning and AI activity** — what we intend to do, what AI suggested, and what changed

These are not interchangeable.

- Planning notes are not evidence.
- AI suggestions are not evidence.
- A polished sentence is not evidence unless it can be traced back to a real source or analysis.

## Source hierarchy

When answering questions or making research claims, use sources in this order:

1. **Primary sources and project data**
   - published literature
   - datasets
   - completed analyses

2. **Project knowledge files**
   - concise summaries of claims that have already been checked against sources

3. **Planning and process files**
   - task lists
   - meeting notes
   - AI decision notes

Only the first two categories should be used to support factual claims. Planning and process files may explain what happened, but they do not prove that a claim is true.

## Provenance: leave a trail

Whenever AI helps create or revise substantive research content, preserve enough provenance that a human can later answer:

- What claim was made?
- What source or analysis supports it?
- When was it checked?
- Who or what contributed to the draft?

At minimum, important research notes should record:

```yaml
provenance:
  created: YYYY-MM-DD
  created_by: human | ai | mixed
  sources:
    - citation_or_path_here
  last_verified: YYYY-MM-DD
  verification_method: brief description
```

The goal is not bureaucracy. The goal is recoverability: future readers should be able to see where an idea came from and how much confidence it deserves.

## How AI assistants should work

AI assistants should:

- use real sources when making factual claims
- clearly distinguish evidence from interpretation
- avoid inventing citations, results, or certainty
- keep changes focused on the requested task
- preserve uncertainty when the evidence is incomplete
- update provenance when creating or materially changing research content
- treat the human researcher as the final decision-maker

AI assistants should not:

- cite planning documents as evidence
- turn brainstorming into settled knowledge
- silently change the meaning of a claim
- hide uncertainty behind fluent prose
- make broad unrelated edits just because they seem helpful

## Simple workflow

A useful default workflow is:

```text
Question or task
      ↓
Check sources and existing project knowledge
      ↓
Draft with AI assistance
      ↓
Verify important claims
      ↓
Record provenance
      ↓
Human review and final decision
```

## When updating project knowledge

If a new research claim is important enough to reuse later, record it in a durable project knowledge file with:

- a short claim statement
- supporting source(s) or analysis
- status, such as `proposed`, `supported`, or `contested`
- provenance metadata

This keeps reusable knowledge separate from temporary conversation, planning, and drafting.

## Practical principle

AI is most useful when it makes research more legible:

- easier to inspect
- easier to verify
- easier to continue later

A good AI-assisted research workflow does not just produce answers. It preserves the path by which those answers were reached.
