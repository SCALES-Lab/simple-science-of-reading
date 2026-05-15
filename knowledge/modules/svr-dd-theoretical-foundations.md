---
type: theoretical_module
status: active
created: 2026-01-25
source: claude_web
topic: model_specification
provenance:
  conversation_date: 2026-01-25
  conversation_id: knowledge-module-grounding-session
  primary_sources:
    # Original Simple View of Reading
    - citation_key: Hoover1990SimpleViewReading
      role: foundational_framework
      pdf: sources/literature/Hoover1990SimpleViewReading.pdf
      notes: "Original SVR formulation: R = D × L"
    - citation_key: Gough1986DecodingReadingReading
      role: foundational_framework
      pdf: sources/literature/Gough1986DecodingReadingReading.pdf
      notes: "Gough & Tunmer (1986) early SVR formulation"
    # Constrained skills framework
    - citation_key: Paris2005ReinterpretingDevelopmentReading
      role: foundational_framework
      notes: "Constrained vs. unconstrained skills distinction (source notes needed)"
    # Automaticity theory (constrained decoding growth)
    - citation_key: LaBerge1974TowardTheoryAutomatic
      role: foundational_framework
      notes: "Automaticity theory for decoding development (not yet in sources/)"
    # Knowledge accumulation (unconstrained comprehension growth)
    - citation_key: Perfetti2007ReadingAbilityLexical
      role: supporting
      pdf: sources/literature/Perfetti2007ReadingAbilityLexical.pdf
      notes: "Lexical quality hypothesis and reading comprehension"
    # Dynamic systems growth model (logistic growth under limited resources)
    - citation_key: vanGeert1991DynamicSystemsModel
      role: foundational_framework
      pdf: sources/literature/vanGeert1991DynamicSystemsModel.txt
      source_notes: sources/literature/vanGeert1991DynamicSystemsModel.notes.md
      notes: "General model of cognitive growth under limited resources; logistic growth equation, carrying capacity, connected growers, feedback delay. Provides formal mathematical foundation for growth functions used in SVR-DD."
  claim_status: proposed
  last_verified: 2026-04-02
  verification_method: "Literature review of SVR foundations, automaticity theory, constrained skills framework, and van Geert (1991) dynamic systems growth model; mathematical formalization of developmental dynamics using logistic growth under limited resources"
  verified_by: "claude_opus_4.6"
related_modules:
  - path: ai/knowledge/modules/mutualism-framework-reading-development.md
    relationship: extends
  - path: ai/knowledge/modules/dual-justification-epistemology.md
    relationship: depends_on
supersedes: []
superseded_by: []
---

# SVR-DD: Simple View of Reading with Developmental Dynamics

## Purpose

This module documents the theoretical foundations for **SVR-DD** (Simple View of Reading with Developmental Dynamics), an extension of the classic SVR model that adds explicit developmental trajectories for decoding (D) and language comprehension (L). SVR-DD formalizes the distinction between constrained and unconstrained skills, generating testable predictions about grade-level variation in reading instruction effectiveness.

**Claim status**: Proposed. Original SVR (Hoover & Gough, 1990) is well-established. Developmental extension integrating constrained/unconstrained framework (Paris, 2005) and automaticity theory requires empirical validation.

---

## Part I: Simple View of Reading (Original Framework)

### Core Formulation

Hoover and Gough (1990) proposed the **Simple View of Reading**:

```
R = D × L
```

Where:
- **R**: Reading comprehension
- **D**: Decoding (word recognition)
- **L**: Language comprehension (linguistic understanding)

**Key insights**:
1. **Multiplicative relationship**: Both D and L are necessary; deficiency in either impairs reading
2. **Component independence**: D and L are conceptually distinct processes
3. **Measurement model**: SVR describes the relationship at a single time point, not developmental change

### Limitations of Original SVR

**What SVR explains**:
- Individual differences in reading comprehension at a given time
- Why both decoding and language skills are necessary
- Framework for diagnosing reading difficulties (poor D, poor L, or both)

**What SVR doesn't explain**:
- How D and L change over time (developmental trajectories)
- Why D-L correlation may increase with age
- Grade-level variation in instruction effectiveness
- Mechanism for skill interaction beyond multiplicative combination

**Need for SVR-DD**: To generate predictions about developmental change and instructional timing, we need explicit growth functions for D and L.

---

## Part II: SVR-DD Mathematical Specification

### Growth Functions

**SVR-DD extends SVR** by adding developmental dynamics:

```
RC(t) = D(t) × L(t)
```

Where:
- **D(t)**: Decoding skill at time t (grade level)
- **L(t)**: Language comprehension at time t
- **RC(t)**: Reading comprehension at time t

**Decoding growth** (constrained skill — logistic growth):
```
ΔD = r_D × D(t) × (K_D - D(t)) / K_D
D(t+1) = D(t) + ΔD
```

- **K_D**: Carrying capacity / asymptotic decoding skill (automaticity ceiling)
- **r_D**: Intrinsic growth rate for decoding
- **Trajectory**: S-shaped (logistic) growth — slow initial acceleration when D is small, fastest growth at D = K_D/2, then deceleration as D approaches K_D

**Rationale for logistic over exponential approach**: The earlier specification used `D(t) = D_max × (1 - exp(-λ_D × t))` (restricted/exponential growth), which is a special case that models growth driven only by unutilized capacity (K - D). Van Geert (1991) demonstrates that cognitive growth is **autocatalytic** — growth depends on both current level D *and* remaining capacity (K - D). The logistic form captures the initial acceleration phase when D is near zero (a beginner learner needs some minimal skill before growth accelerates), which the exponential approach omits. The simulation code (`analyses/simulations/components/skill_dynamics.py`) already correctly implements the logistic form.

**Language comprehension growth** (unconstrained skill — logistic growth with high K, or linear approximation):
```
Primary: ΔL = r_L × L(t) × (K_L - L(t)) / K_L    (logistic, K_L >> L within K-5)
Approximation: L(t) ≈ L_0 + β_L × t               (linear, valid when L << K_L)
```

- **K_L**: Carrying capacity for language comprehension (very high; effectively unconstrained within K-5 timeframe)
- **r_L**: Intrinsic growth rate for language comprehension
- **L_0**: Initial language comprehension
- **β_L**: Effective linear growth rate (approximation when L << K_L)
- **Trajectory**: Approximately linear within K-5 range because K_L >> L(t), but growth is fundamentally autocatalytic — knowing more words makes learning new words easier (van Geert, 1991)

**Rationale**: Van Geert (1991) argues that all cognitive growth occurs under limited resources and follows logistic dynamics. The distinction between constrained and unconstrained skills (Paris, 2005) maps to *different carrying capacities* rather than different growth functions: constrained skills have K within the developmental timeframe; unconstrained skills have K far above attainable levels during K-5. The linear approximation is adequate for the K-5 timescale but the underlying mechanism is autocatalytic.

### Parameters and Cognitive Grounding

| Parameter | Cognitive Mechanism | Literature Source |
|-----------|---------------------|-------------------|
| **K_D** | Carrying capacity / automaticity ceiling for word recognition | LaBerge & Samuels (1974); van Geert (1991) carrying capacity concept |
| **r_D** | Intrinsic growth rate for decoding | Paris (2005) constrained skills; van Geert (1991) logistic growth |
| **K_L** | Carrying capacity for language comprehension (very high) | van Geert (1991); Paris (2005) unconstrained = high K |
| **r_L** | Intrinsic growth rate for language comprehension | Paris (2005) unconstrained skills |
| **L_0** | Initial vocabulary/language knowledge | Perfetti (2007) lexical quality |
| **f** | Feedback delay (time lag between growth state and effect) | van Geert (1991) — currently omitted; potential calibration parameter |

**Critical assumptions**:
1. Decoding approaches an asymptote (K_D) due to **automaticity** — once orthographic-phonological mappings are learned and practiced, further gains are minimal.
2. Language comprehension has a **very high carrying capacity** (K_L >> K_D) — vocabulary, background knowledge, and inferential strategies continue growing throughout the K-5 timeframe.
3. Both skills grow via **autocatalytic logistic dynamics** (van Geert, 1991) — growth depends on current level and remaining capacity, not just remaining capacity alone.
4. **Carrying capacity may be dynamic** — instructional environments (SoR vs. control) may change the effective K for decoding, not just growth rate r (van Geert, 1991, K-adaptation).

---

## Part III: Theoretical Grounding

### Constrained vs. Unconstrained Skills (Paris, 2005)

Paris (2005) distinguished:

**Constrained skills**:
- Finite set of elements to master (e.g., 26 letters, ~44 phonemes, grapheme-phoneme correspondences)
- Developmental trajectories approach asymptotic mastery
- Examples: Alphabet knowledge, phonemic awareness, basic decoding, sight word recognition

**Unconstrained skills**:
- Open-ended domain with no mastery ceiling
- Developmental trajectories continue indefinitely
- Examples: Vocabulary, background knowledge, comprehension strategies, metacognition

**Mapping to SVR-DD** (refined via van Geert, 1991):
- **D (Decoding)**: Constrained → carrying capacity K_D within K-5 timeframe → logistic growth to asymptote
- **L (Language Comprehension)**: Unconstrained → carrying capacity K_L >> K_D → logistic growth that approximates linear within K-5

### Automaticity Theory (LaBerge & Samuels, 1974)

**Core mechanism**: Repeated practice of word recognition leads to **automatic processing**:

1. **Early decoding** (K-1): Effortful phonological recoding, attention-demanding
2. **Developing automaticity** (1-3): Increased fluency, orthographic pattern recognition
3. **Automatic decoding** (3+): Rapid, effortless word recognition; attention freed for comprehension

**Implication for SVR-DD**: Automaticity development follows **logistic growth** toward an asymptote K_D. Growth is initially slow (minimal structural growth level), accelerates as foundational mappings are established, then decelerates as the skill approaches ceiling. Van Geert (1991) provides the formal justification: the carrying capacity K_D represents the limited set of orthographic-phonological mappings to be mastered, and growth is autocatalytic because each learned mapping supports the learning of related mappings.

**Developmental prediction**: Decoding growth rate (dD/dt) is highest at mid-development when D ≈ K_D/2 (the inflection point of the logistic curve). By grade 3-4, D approaches K_D and dD/dt → 0.

### Dynamic Systems Framework (van Geert, 1991)

**Core framework**: Cognitive growth as a process of growth under limited resources, formalized via the logistic growth equation with feedback delay.

**Key concepts for SVR-DD**:
- **Carrying capacity (K)**: The maximal stable level a cognitive grower can attain given available resources. For decoding, K_D is bounded by the finite set of orthographic-phonological mappings. For language comprehension, K_L is very high relative to K-5 attainment.
- **Autocatalytic growth**: Growth depends on current level (L) *and* remaining capacity (K - L). A learner needs some foundational skill before growth accelerates — this explains the initial slow phase of decoding development.
- **Connected growers**: D and L are not independent but interact as cognitive species in a mental ecology. Growth in one can support or compete with growth in the other (see mutualism module).
- **Dynamic carrying capacity (K-adaptation)**: K is not necessarily fixed; instructional environments can raise or lower K. SoR instruction may increase K_D (providing more systematic exposure to orthographic patterns), not just r_D.
- **Feedback delay (f)**: Time lag between a learning event and its observable effect on performance. In reading: phonics instruction at time t may not manifest as improved decoding until t + f. Currently omitted from SVR-DD but a potential calibration parameter.
- **Stage-like transitions from continuous dynamics**: The apparent qualitative shift from "learning to read" (K-2) to "reading to learn" (3-5) can emerge from continuous logistic growth without requiring a discrete structural change — it reflects the point where D approaches K_D and L becomes the dominant growth process.

### Knowledge Accumulation (Perfetti, 2007; Anderson & Freebody, 1981)

**Core mechanism**: Language comprehension depends on accumulated knowledge:

- **Vocabulary**: Tens of thousands of words learned over development
- **Background knowledge**: Domain-specific schemas, world knowledge
- **Syntactic knowledge**: Increasingly complex grammatical structures
- **Pragmatic knowledge**: Genre conventions, discourse structures

**Implication for SVR-DD**: No ceiling on knowledge acquisition within the K-5 timeframe. Van Geert (1991) would characterize this as logistic growth with a very high carrying capacity K_L — the constraint is real but not binding during childhood. The growth is still autocatalytic: knowing more words makes learning new words easier (vocabulary begets vocabulary).

**Developmental prediction**: Language comprehension growth rate (dL/dt) is approximately constant across K-5 grades when L << K_L (the linear approximation), though may accelerate with reading volume through mutualism (D → L facilitation) and the autocatalytic property of knowledge accumulation.

---

## Part IV: Testable Predictions for Grade-Level Variation

### Prediction 1: Decoding Plateau Effect

**Derivation**: If D(t) → D_max by grade 3-4, then dD/dt → 0 in later grades.

**Testable implication**: ECLS-K data should show:
- Rapid decoding growth K-2 (large dD/dt)
- Plateau in decoding growth 3-5 (small dD/dt)
- **Phenomenon signature P1**

### Prediction 2: Continuous Comprehension Growth

**Derivation**: If L(t) has no asymptote, then dL/dt > 0 across all grades.

**Testable implication**: ECLS-K data should show:
- Continuous vocabulary/comprehension growth K-5
- No plateau in language measures
- **Phenomenon signature P2**

### Prediction 3: Grade-Specific Intervention Effects

**Derivation**: Instructional impact on RC depends on component limiting factors:
- **Early grades (K-2)**: D is limiting (low D, high dD/dt) → decoding intervention accelerates D → large RC gains
- **Later grades (3-5)**: L is limiting (D near D_max, low dD/dt) → decoding intervention minimal effect on D → small RC gains

**Testable implication**: SoR intervention studies should show:
- Larger effect sizes for K-2 than 3-5
- Grade × intervention interaction
- **Phenomenon signature P4**

### Prediction 4: Increasing D-L Correlation

**Derivation**: If D plateaus while L grows, variance in RC shifts from D-driven (early) to L-driven (later).

**Additional mechanism**: Mutualism (van der Maas et al., 2006) predicts reciprocal facilitation increases D-L correlation over time.

**Testable implication**: ECLS-K longitudinal data should show:
- Lower D-L correlation in K-1 (processes relatively independent)
- Higher D-L correlation in 4-5 (accumulated covariance)
- **Phenomenon signature P3**

### Prediction 5: Component-Specific Growth Rates

**Derivation**: Paris (2005) predicts faster learning rates for constrained skills (finite mastery set) than unconstrained skills (open-ended).

**Testable implication**: λ_D (decoding growth rate) > β_L (language growth rate) in early grades, but λ_D declines as D → D_max.

---

## Validation Criteria

### External Coherence
- **Grounded in reading science**: Hoover & Gough (1990) SVR, Paris (2005) constrained skills, LaBerge & Samuels (1974) automaticity
- **Grounded in dynamic systems theory**: van Geert (1991) logistic growth under limited resources — provides formal mathematical foundation for growth functions and connected grower dynamics
- **Cognitive mechanisms**: Automaticity (D asymptote as carrying capacity), knowledge accumulation (L as high-K logistic growth), autocatalytic growth, connected growers
- **Empirical patterns**: Predicts phenomenon signatures P1-P7 from ECLS-K data

### Internal Coherence
- SVR-DD preserves original SVR at measurement level: RC = D × L
- Growth functions mathematically consistent
- Constrained (D) vs. unconstrained (L) distinction logically derived from cognitive theories

### Integrative Coherence
- Testable via longitudinal data: fit growth curves to ECLS-K trajectories
- Testable via intervention studies: compare grade-specific effect sizes
- Computational implementation: Mesa agent-based model can simulate SVR-DD and generate predictions

---

## References

Anderson, R. C., & Freebody, P. (1981). Vocabulary knowledge. In J. Guthrie (Ed.), *Comprehension and teaching: Research reviews* (pp. 77-117). International Reading Association.

Gough, P. B., & Tunmer, W. E. (1986). Decoding, reading, and reading disability. *Remedial and Special Education, 7*(1), 6-10.

Hoover, W. A., & Gough, P. B. (1990). The simple view of reading. *Reading and Writing, 2*(2), 127-160.

LaBerge, D., & Samuels, S. J. (1974). Toward a theory of automatic information processing in reading. *Cognitive Psychology, 6*(2), 293-323.

Paris, S. G. (2005). Reinterpreting the development of reading skills. *Reading Research Quarterly, 40*(2), 184-202.

Perfetti, C. (2007). Reading ability: Lexical quality to comprehension. *Scientific Studies of Reading, 11*(4), 357-383.

van Geert, P. (1991). A dynamic systems model of cognitive and language growth. *Psychological Review, 98*(1), 3-53.

---

## Claim Ledger

| ID | Claim (atomic, testable) | Scope / Conditions | Evidence Pointer(s) | Status | Notes |
|----|--------------------------|-------------------|---------------------|--------|-------|
| C1 | Reading comprehension = Decoding × Language Comprehension (SVR) | Measurement model, single time point | Hoover1990; Gough1986 | established | Original SVR |
| C2 | Decoding exhibits constrained logistic growth to carrying capacity K_D due to automaticity | K-5 reading development | Paris2005; LaBerge1974; vanGeert1991 Q4-Q6, Q8-Q9; #part-iii | proposed | SVR-DD extension; logistic (not exponential) per van Geert (1991) |
| C3 | Language comprehension exhibits high-K logistic growth that approximates linear within K-5 | K-5 and beyond | Paris2005; Perfetti2007; vanGeert1991 Q2, Q4; #part-iii | proposed | Refined: not purely linear but logistic with K_L >> attainable level |
| C4 | Decoding growth rate (dD/dt) is highest at mid-development (D ≈ K_D/2), near zero when D → K_D | Early reading development | vanGeert1991 Q9; #part-iv prediction 1 | proposed | Testable via ECLS-K (P1); logistic inflection point |
| C5 | Language comprehension growth rate (dL/dt) remains positive across all grades | K-5 reading development | #part-iv prediction 2 | proposed | Testable via ECLS-K (P2) |
| C6 | SoR decoding interventions are most effective in early grades (K-2) when D is limiting | Instructional timing effects | #part-iv prediction 3 | proposed | Testable via meta-analysis (P4) |
| C7 | D-L correlation increases from early to later grades due to variance shift and mutualism | Longitudinal correlation patterns | vanGeert1991 Q10; #part-iv prediction 4 | proposed | Testable via ECLS-K (P3) |
| C8 | SVR-DD with constrained D and unconstrained L generates grade-level variation in instruction effects | Theoretical sufficiency | #part-iv; computational model | proposed | Model comparison needed |
| C9 | Both D and L grow via autocatalytic logistic dynamics under limited resources | General cognitive growth | vanGeert1991 Q1, Q8; #part-ii | proposed | Constrained vs. unconstrained = different K, same growth function |
| C10 | Carrying capacity for decoding (K_D) may be dynamic, adapting to instructional environment | SoR vs. control conditions | vanGeert1991 Q11; #part-iii dynamic systems | proposed | Instruction may change K_D, not just r_D |
| C11 | Apparent stage-like transition from D-limited to L-limited reading emerges from continuous logistic dynamics | K-2 → 3-5 developmental shift | vanGeert1991 Q13; #part-iii dynamic systems | proposed | No discrete structural change required |

**Status key**: proposed | accepted | established | contested | deprecated

---

## Evidence Snippets

> **E1 (Hoover1990SimpleViewReading, p. 130):** [SVR formulation R = D × L - requires PDF extraction]
> See: sources/literature/Hoover1990SimpleViewReading.pdf (available for extraction)

> **E2 (Gough1986DecodingReadingReading, p. 7):** [Early SVR formulation - requires PDF extraction]
> See: sources/literature/Gough1986DecodingReadingReading.pdf (available for extraction)

> **E3 (Paris2005ReinterpretingDevelopmentReading, p. 186):** "Constrained skills are characterized by developmental trajectories that are negatively accelerating and approach asymptotic levels of mastery... Unconstrained skills, by contrast, develop along trajectories that are more variable and do not approach mastery."
> See: Paris (2005) p. 186 (source notes needed)

> **E4 (LaBerge1974TowardTheoryAutomatic):** [Automaticity theory - requires PDF acquisition and extraction]
> See: LaBerge & Samuels (1974) *Cognitive Psychology* (PDF not yet in sources/)

> **E5 (Perfetti2007ReadingAbilityLexical):** [Lexical quality and comprehension - requires PDF extraction]
> See: sources/literature/Perfetti2007ReadingAbilityLexical.pdf (available for extraction)

> **E6 (vanGeert1991DynamicSystemsModel, p. 3):** "I define cognitive growth as an autocatalytic quantitative increase in a growth variable following the emergence of a specific structural possibility in the cognitive system."
> See: vanGeert1991DynamicSystemsModel.notes.md Q1

> **E7 (vanGeert1991DynamicSystemsModel, p. 7):** "Carrying capacity is a function that one-dimensionally expresses the sum of resources over time in terms of a maximal stable level a grower may attain given these resources."
> See: vanGeert1991DynamicSystemsModel.notes.md Q5

> **E8 (vanGeert1991DynamicSystemsModel, p. 10):** "I try to demonstrate that there is a general model of quantitative increase or decrease in cognitive development, namely a dynamic systems model of logistic growth. This model is intended to apply to all theories that subscribe to the idea that cognitive growth occurs under the constraint of limited resources."
> See: vanGeert1991DynamicSystemsModel.notes.md Q8

> **E9 (vanGeert1991DynamicSystemsModel, p. 37):** "The tutorial environment adapts its support to a current, low growth level and raises that support as a consequence of increase in the grower. This process amounts to a temporary adaptation of the effective carrying capacity."
> See: vanGeert1991DynamicSystemsModel.notes.md Q11

> **E10 (vanGeert1991DynamicSystemsModel, p. 42):** "What makes the difference between an apparently slow and quasi-linear increase in a variable and an almost quantum-leap-like emergence of the steady state of a variable is the height of the growth rate factor rather than some hidden structural factor."
> See: vanGeert1991DynamicSystemsModel.notes.md Q13

---

## Supersession Ledger

| Date | Old Term/Formulation | New Term/Formulation | Reason |
|------|---------------------|---------------------|--------|
| 2026-04-02 | D(t) = D_max × (1 - exp(-λ_D × t)) | ΔD = r_D × D(t) × (K_D - D(t)) / K_D | Logistic growth replaces exponential approach; van Geert (1991) shows restricted growth omits initial acceleration phase |
| 2026-04-02 | D_max (fixed asymptote) | K_D (carrying capacity, potentially dynamic) | Carrying capacity concept from van Geert (1991) allows K to adapt to instructional environment |
| 2026-04-02 | λ_D (exponential decay rate) | r_D (intrinsic logistic growth rate) | Parameter reinterpreted under logistic framework |
| 2026-04-02 | L(t) = L_0 + β_L × t (linear, unconstrained) | L: logistic with K_L >> L (linear approximation valid for K-5) | Van Geert (1991): all cognitive growth is autocatalytic under limited resources; "unconstrained" = high K, not absent K |

---

## Change Log

| Date | Change | Reason |
|------|--------|--------|
| 2026-01-25 | Created module | Ground evidence for decision memo 2025-12-11__model__svr-dd-formalization.md |
| 2026-04-02 | Major update: growth functions, claims, evidence from van Geert (1991) | Integrated dynamic systems framework: logistic growth replaces exponential approach for D; L recharacterized as high-K logistic; added carrying capacity dynamics, feedback delay, connected growers, stage emergence concepts; added claims C9-C11; added evidence snippets E6-E10 |
