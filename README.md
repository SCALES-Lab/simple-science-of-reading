# SVR-DD: Simple View of Reading — Developmental Dynamics

This project develops **SVR-DD**, a developmental extension of the **Simple View of Reading**. The aim is to move from a largely static account of reading comprehension toward models that explain **how reading develops across the elementary and middle-school years**.

The central question is:

> If reading comprehension depends on decoding and language comprehension, what developmental mechanisms best explain how those components change together over time?

SVR-DD is being developed as a model-comparison framework rather than a single preferred model. The project will compare mathematical models built from different mechanistic accounts of reading development and evaluate how well each reproduces observed developmental patterns. One prominent candidate is a **mutualism model**, in which reading-related skills strengthen one another through reciprocal interactions over time.

## Project goals

This project aims to:

- express competing theories of reading development as explicit mathematical models
- identify developmental patterns that can distinguish among those models
- evaluate candidate models against longitudinal data
- clarify what each model implies about how reading develops

The broader goal is not only to predict reading outcomes, but to use models to sharpen theory.

## Conceptual background

The project draws on three lines of work:

1. **The Simple View of Reading** — reading comprehension as a function of decoding and linguistic comprehension.
2. **Developmental reading theory** — including work on cumulative advantage and changing relations among skills over time.
3. **Dynamical systems approaches** — especially models in which observed correlations emerge from interactions among developing processes.

These traditions motivate the project while leaving open an empirical question: which developmental mechanisms best account for reading growth from kindergarten through middle school?

## Data and measures

The current empirical work uses longitudinal data from the **Early Childhood Longitudinal Study, Kindergarten Class of 1998–99 (ECLS-K:1998)**, with repeated assessments from kindergarten through eighth grade.

The present data workflow prepares measures relevant to SVR-DD, including:

- reading achievement outcomes
- reading proficiency measures used as provisional decoding indicators
- general knowledge measures used as provisional language-comprehension indicators
- comparison measures such as mathematics and science achievement

These construct mappings are provisional and remain part of the modeling work rather than fixed conclusions.

## Candidate model families

The project is organized around comparison among model families such as:

- **Static or weakly developmental SVR baselines**
- **Autoregressive developmental models**
- **Mutualism models** with reciprocal relations among component skills
- **Alternative mechanistic models** that encode different assumptions about directionality, constraint, or stage-specific change

For each model family, the project will ask:

1. What developmental mechanism does the model represent?
2. What observable patterns should that mechanism produce?
3. Which patterns appear in the data?
4. What findings would count against the model?

## Repository map

```text
.
├── sources/                              # Source materials and notes
├── data/                                 # Project data files
├── scripts/R/                            # Data import and processing workflows
├── knowledge/modules/                    # Durable theory and claim modules
├── ai/decision/                          # Project decision records
├── ai/skills/                            # Project-local assistant skills
└── products/manuscripts/paper1-svr-dd/   # Manuscript workspace
```

## Project-local skills

The repository includes a small set of project-local assistant skills in `ai/skills/`:

- `knowledge-integrity`
- `decision-notes`
- `source-notes`

These skills preserve project-specific workflows alongside the research materials so they remain available when the repository is shared or cloned.

## Current status

Work currently underway includes:

- preparing longitudinal ECLS-K measures for model calibration
- refining the theoretical specification of SVR-DD
- formalizing candidate developmental models
- identifying empirical signatures that can discriminate among models
- developing the first manuscript for the project

## Guiding idea

Reading development is not only a question of whether children differ, but of **how developmental trajectories are generated**. SVR-DD treats mathematical models as tools for making those developmental claims precise enough to compare, test, and revise.

## Contact

For project inquiries, contact `wmm0017@auburn.edu`.
