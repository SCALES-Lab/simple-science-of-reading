---
type: source_notes
citation_key: VanDerMaas2006DynamicalModelGeneralIntelligence
source_type: article
pdf_available: true
access_method: pdf_in_repo
created: 2026-01-11
last_read: 2026-01-11
reader: Claude
---

# Van der Maas et al. (2006) - A Dynamical Model of General Intelligence: The Positive Manifold of Intelligence by Mutualism

## Bibliographic Information

van der Maas, H. L. J., Dolan, C. V., Grasman, R. P. P. P., Wicherts, J. M., Huizenga, H. M., & Raijmakers, M. E. J. (2006). A dynamical model of general intelligence: The positive manifold of intelligence by mutualism. *Psychological Review, 113*(4), 842-861.

- DOI: 10.1037/0033-295X.113.4.842
- BibTeX key: `VanDerMaas2006DynamicalModelGeneralIntelligence`
- PDF: `VanDerMaas2006DynamicalModelGeneralIntelligence.pdf`

---

## Summary

This landmark paper proposes a **mutualism model** as an alternative explanation for the positive manifold of intelligence (the robust finding that cognitive test scores are positively intercorrelated). Rather than positing a single underlying g factor as a quantitative latent variable, the authors argue that the positive manifold emerges purely from **positive beneficial interactions (mutualism)** between cognitive processes during development.

**Core thesis**: In a dynamical developmental model with reciprocal causation between cognitive processes, all processes start uncorrelated. During development, positive mutualistic interactions cause correlations to emerge, producing a positive manifold and a single dominant factor in factor analysis—**without requiring a general g factor as an underlying quantitative variable**.

The model is formalized using Lotka-Volterra mutualism equations from population biology. Simulations demonstrate that:
1. Mutualism alone generates positive manifold (Scenario 3)
2. Model explains hierarchical factor structures when interaction matrix M varies
3. Model accounts for: low predictability from infancy, integration/differentiation effects, heritability increases with age, Jensen effect, Flynn effect
4. **Critical distinction**: High IC example (mutualism specifies organized mechanism) vs. low IC example (ego depletion leaves resource unspecified)

---

## Key Sections

### Introduction and Theoretical Framework (pp. 842-843)

**Main argument**: The positive manifold is well-established psychometrically, but correlation analysis alone cannot establish g as an actual underlying variable. Alternative mechanisms must be excluded.

**Three explanations of positive manifold**:
1. **g explanation** (dominant): Single quantitative latent factor (mental energy, processing speed, working memory, brain size, neural efficiency)
2. **Sampling theory** (Thomson): Overlapping lower-order modules/bonds cause correlations (rejected due to empirical problems)
3. **Mutualism** (NEW): Positive developmental interactions between processes

**Key concepts**:
- **Positive manifold**: Test scores on cognitive tasks invariably positively intercorrelated
- **g (psychometric)**: Outcome of factor analysis; summary measure of positive manifold
- **g (psychological)**: Controversial—does psychometric g identify with psychological/biological variable?
- **Mutualism**: Reciprocal beneficial relationships between cognitive processes during development

### The Ecosystem Metaphor (pp. 843-844)

**Biological analogy**: Suppose we measure multiple aspects of lake ecosystems (water quality, biodiversity, flora/fauna). If these show positive manifold and dominant general factor, do we infer a "lake g factor" or "lake mental energy"?

**Alternative explanation**: In biology, ecosystems are modeled with coupled differential equations (Lotka-Volterra). Correlations arise from **interactions** (competition, cooperation) between components, not from single underlying factor.

**Application to intelligence**: Positive manifold may be by-product of positive interactions between cognitive processes during development. Initially uncorrelated processes become correlated through dynamical interactions.

### A Simple Dynamical Model (pp. 844-846, Equation 3)

**Core equation**:
```
dxᵢ/dt = aᵢxᵢ(1 - xᵢ/Kᵢ) + aᵢΣⱼ₌₁ᵂ Mᵢⱼxⱼxᵢ/Kᵢ
```

**Components**:
- **xᵢ**: W cognitive processes (e.g., perception, memory, decision, reasoning)
- **aᵢ**: Growth parameters (steepness of logistic growth)
- **Kᵢ**: Carrying capacity/limited resources (biological constraints: neural speed, system size)
- **M**: Interaction matrix—weights Mᵢⱼ specify mutualistic relations between process pairs

**Key assumptions**:
1. Intelligence based on underlying cognitive processes (agnostic about specific architecture)
2. Processes develop via logistic growth (auto-catalytic, self-regulating)
3. **Positive mutualistic relations**: Each process supports development of others (e.g., better short-term memory → better strategies → more efficient memory)
4. Resources Kᵢ conceptualized as biological constraints

**Dynamics**: For appropriate parameters, each xᵢ converges to steady state. Asymptotic states independent of initial values x₀ and growth rates a—depend only on K and M.

### Explaining the Positive Manifold: Three Scenarios (pp. 846-848)

**Scenario 1 (No Positive Manifold)**: All Mᵢⱼ = 0, parameters uncorrelated
- Result: Zero correlations, zero-factor model fits

**Scenario 2 (g explanation)**: K parameters correlated (r = .5), all Mᵢⱼ = 0
- Result: Positive manifold (r ≈ .5), one-factor model fits, all variables load highly on g
- Interpretation: Above-average performance explained by above-average biological resources (classic g scenario)

**Scenario 3 (Mutualism)**: All Mᵢⱼ = .05, K (and a, x₀) uncorrelated
- Result: Positive manifold (r ≈ .5), one-factor model fits, all variables load highly on g
- **CRITICAL**: Positive manifold emerges **without underlying g factor**
- Individual differences due to weighted sum of K (mutualism amplifies small random differences in average K)

**Key insight**: Mutualism produces same psychometric pattern (positive manifold, dominant first factor) as g explanation, but mechanism is fundamentally different—**no single quantitative latent variable required**.

### Hierarchical Factor Structures (pp. 849-850)

Real data require **correlated first-order factors** (hierarchical g). Can mutualism explain this?

**Yes—through variance in M**:
- When Mᵢⱼ sampled from distribution (mean = .05, varying SD), correlation variance increases
- More factors needed to describe data as SD increases
- Correlation matrices of factor scores show positive manifold (hierarchical structure)

**Controlled demonstration** (Table 1, Figure 7): Specify M with high within-group interactions (.08) and low between-group interactions (.02) for four groups
- Result: Four-factor model fits, factors intercorrelated, single common factor fits factor covariance matrix
- Produces hierarchical confirmatory factor model: four group factors + one general factor

**Fluid (gf) vs. Crystallized (gc) intelligence**: Can model asymmetry via:
1. Asymmetric M (gf processes influence gc, not vice versa)
2. Bootstrap dynamics (Kᵢ of gc depends on x of gf)
3. Lower growth rates a for gc processes

### Development of Intelligence (pp. 850-851)

**Low infant-adult correlation**: Asymptotic states independent of x₀ and a → low/zero correlation between initial and later performance (matches Bayley 1949 findings)

**Increasing stability**: Correlation between test performance and asymptotic performance increases during development (Figure 2c)—actual growth speed depends on a, K, AND M

**Why?** Initially, x₀ and a determine variance in x. Later, K (weighted by M) determines variance. Growth speed and asymptotic performance become correlated even though parameters uncorrelated.

### Differentiation Effects (pp. 851-853, Figure 8)

**Two differentiation phenomena** (mixed empirical evidence):
- **Age differentiation**: Decline of g with age
- **Ability differentiation**: Stronger g in low-IQ groups

**Mutualism model predicts complex integration/differentiation**:

**Scenario 2 (g model)**: Only integration—first eigenvalue increases monotonically with mean x

**Scenario 3 (Mutualism, Mᵢⱼ = .05)**: **Integration followed by differentiation**
- First eigenvalue peaks then declines
- Mechanism: Influence of a declines before influence of K increases
- Robust across parameter settings

**Scenario 3b (Higher mutualism, Mᵢⱼ = .065)**: Short integration period, then stable g
- Integration finished before mean x rises
- More consistent with data (initial integration, then stability)

**Increasing variance of M during development**: Mimics investment/constraint models
- Certain interactions strengthen, others weaken/become competitive
- Number of factors increases, some processes decline in adulthood
- First eigenvalue and number of factors show different integration/differentiation patterns

### Heritability of Intelligence (pp. 852-854)

**Jensen effect**: Correlation between heritability and g-loadings of cognitive tests (r > .5)

**Mutualism explanation**:
- Model K as: Kᵢ = cᵢGᵢ + (1-cᵢ)Eᵢ (G = genetic, E = environment, c = weight)
- Heritability h² = c²
- If all Gᵢ and Eᵢ uncorrelated with same means/SDs, different uncorrelated genetic influences can cause high heritability of g

**Increase in heritability during development**: Initially x determined by x₀ and a (low genetic influence). Later x determined by genetic part of K (high genetic influence). Matches Bartels et al. (2002), Fulker et al. (1988) findings.

**Jensen effect requires**: Very weak but nonzero genetic intercorrelations between Gᵢ (r = .01-.09 sufficient, Figure 9)
- Consistent with QTL research finding no single-gene strong correlations with g

### Flynn Effect and IQ Paradox (pp. 854-855)

**IQ paradox** (Dickens & Flynn 2001): How can high heritability and large environmental influence coexist?

**Solution**: Strong reciprocal causation between phenotypic IQ and environment (gene-environment correlation masks environmental potency)

**Mutualism model consistent**: Can extend to include reciprocal causal relations between cognitive processes AND environmental processes
- Explains differential Flynn effects across subtests
- Specifying precise environment-cognition relations could explain differential generation effects

### The Interpretation of High g Loadings (pp. 854-855, Figure 10)

**Critical implication**: High g loadings ambiguous—can mean two very different things:

1. **High influence**: Process strongly influences many other processes (high Mᵢⱼ in row)
2. **Highly influenced**: Process strongly influenced by many processes (high Mᵢⱼ in column)

**Figure 10 demonstrates**: Both produce high g loading for process 16
- **Differs fundamentally from g explanation**: In g model, high loading means strong relationship to underlying g factor
- In mutualism, high loading reflects position in network of developmental interactions

**Intervention implications**: Training high-g-loading processes (e.g., working memory) may be ineffectual
- In complex systems, manipulating single variable often fails
- Interventions can have counterintuitive effects

---

## Quotes

> **Q1 (p. 842):** "Scores on cognitive tasks used in intelligence tests correlate positively with each other, that is, they display a positive manifold of correlations. The positive manifold is often explained by positing a dominant latent variable, the g factor, associated with a single quantitative cognitive or biological process or capacity. In this article, a new explanation of the positive manifold based on a dynamical model is proposed, in which reciprocal causation or mutualism plays a central role."

> **Q2 (p. 843):** "What we have done is to demonstrate that what we have observed is what we would have expected if an underlying variable, called g, did exist. It leaves open the possibility that some other mechanism could have produced the correlation." [Bartholomew 2004 quote]

> **Q3 (p. 843):** "Our dynamical explanation of the positive manifold of cognitive tasks is based on this type of interaction in multivariate dynamical systems... We argue that the positive manifold may be a by-product of the positive interactions between the different cognitive processes of the system."

> **Q4 (p. 844):** "We propose to view the cognitive system as a developing ecosystem (or society) with primarily cooperative relations between cognitive processes. Note that this model does not make use of latent variables."

> **Q5 (p. 845):** "This is a mutualism model (Murray, 2002). This is the simplest instance of a model for mutualism, but it suffices for our present purposes."

> **Q6 (p. 848):** "These results support the view, and the weighted sum of uncorrelated K is not a common factor, in the factor analytic sense (i.e., a single underlying variable). For instance, one person's high performance on cognitive tasks may be due to exceptionally high Kᵢ for certain processes (e.g., memory processes), another person's high performance may be due to high Kᵢ for completely other processes (e.g., language processes)... This differs fundamentally from the g explanation."

> **Q7 (p. 851):** "The mutualism model allows for both integration and differentiation... it is interesting, as no additional mechanism was invoked to create differentiation."

> **Q8 (p. 855):** "An important implication of the mutualism model is that high g loadings of variables or (first-order) factors in a factor analysis can mean two very different things: the processes associated with these variables may either influence or be influenced by many other processes."

> **Q9 (p. 856):** "The positive manifold, g, and general intelligence are often viewed as synonymous. We have shown that positive manifold does not necessarily imply a single quantitative latent factor... We prefer to associate general intelligence with the positive manifold, so that we may view the mutualism model as a model of general intelligence in the sense that it explains why people, who are good at one test, are good at other tests as well."

---

## Connections to Knowledge Modules

| Quote ID | Supports Claim | Module | Notes |
|----------|---------------|--------|-------|
| Q1, Q2, Q4 | C11 (Mutualism Analysis) | tripartite-architecture | High IC example: mutualism specifies organized mechanism |
| Q5, Q6 | C11 | tripartite-architecture | Positive manifold from interactions, not latent variable |
| Q8, Q9 | C11 | tripartite-architecture | Mechanistic specification enables novel predictions |
| Q3, Q7 | C2 (Mechanistic Organization) | tripartite-architecture | Integration as emergent property of mutualistic dynamics |

---

## Critical Notes

**Strengths as high IC/high EC exemplar**:

1. **Mechanistic organization (High IC)**:
   - **Specifies organized mechanism**: Lotka-Volterra mutualism equations with logistic growth
   - **Explains phenomenon via mechanism**: Positive manifold emerges from mutualistic interactions during development
   - **Integration**: Multiple components (growth dynamics, interaction matrix, resource constraints) work together
   - **Parsimony with power**: Simple model (Equation 3) explains diverse phenomena (positive manifold, hierarchical structure, development, heritability, differentiation, Flynn effect)
   - **Novel predictions**: High g loadings ambiguous (influence vs. influenced), training high-g processes may be ineffectual

2. **Mechanistic grounding (High EC)**:
   - **Vertical connection**: Grounded in population biology (Lotka-Volterra models, well-established in ecology)
   - **Biological plausibility**: Resources K as neural constraints (speed, system size); growth parameters as biological development
   - **Lower-level anchor**: Interaction matrix M potentially mappable to specific cognitive/neural processes
   - **Cross-domain generalization**: Same formalism applies to ecosystems, cognitive development, social systems

3. **Performative coherence (High PC)**:
   - Generated extensive follow-up research (computational models, empirical tests)
   - **Competitive advantage**: Offers mechanism where g theory offers statistical description
   - **Scope**: Explains phenomena difficult for g theory (differentiation without additional mechanism, low infant-adult correlation)

**Critical comparison to ego depletion (low IC/low EC)**:

**Mutualism (HIGH IC/EC)**:
- Specifies mechanism: Reciprocal causation via interaction matrix M
- Grounded: Lotka-Volterra equations from population biology
- Testable: Predictions about M structure, developmental trajectories, intervention effects
- Integration: Growth dynamics + interactions + resources unified

**Ego depletion (LOW IC/EC)**:
- Black-box: "Resource" unspecified (not glucose, not motivation, not neural activation)
- Ungrounded: No connection to physiology, neuroscience, or cognitive architecture
- Functional only: "Depletion" explains everything but specifies nothing
- Shallow: One unspecified resource does all explanatory work

**Why this contrast matters for Paper 1**:
- **Demonstrates IC/EC independence from PC**: Both models highly cited, but mechanistic depth differs dramatically
- **Shows vulnerability**: Ego depletion's lack of mechanism left it open to replication failures and theoretical challenges
- **Illustrates amplification**: Mutualism's high IC+EC created virtuous cycle (mechanistic specification → novel predictions → targeted empirical tests → theoretical refinements)
- **Validates tripartite analysis**: Two theories explaining same general phenomenon (resource limits on self-regulation vs. positive manifold) with radically different IC/EC profiles

**Potential limitations**:

1. **Parameter proliferation**: Matrix M has W² elements—requires constraints for falsifiability
2. **Specific processes unclear**: Model agnostic about which cognitive processes constitute x
3. **Static M**: Most simulations use fixed M; developmental changes in M (investment hypothesis) added post-hoc
4. **Empirical validation sparse**: Model demonstrates sufficiency but not necessity; needs direct tests of mutualistic interactions
5. **Alternative sampling theory**: Modern genetic formulations (Anderson 2001) not fully addressed

**Relation to tripartite architecture** (Paper 1 claims):

- **C2 (Mechanistic Organization)**: Mutualism exemplifies organized mechanism creating IC
- **C4 (Mechanistic Grounding)**: Grounding in population biology creates EC (vertical coherence)
- **C5 (Specificity-Precision Amplification)**: High IC (mechanistic organization) + High EC (biological grounding) → virtuous cycle of theoretical development
- **C11 (Mutualism Analysis)**: Explicitly contrasted with ego depletion as high vs. low IC/EC
- **C18 (Coherence Crisis)**: Demonstrates how mechanistic specification prevents pathologies of atheoretical empiricism

**Methodological innovation**:
- Imports mature formalism (Lotka-Volterra) from biology to psychology
- Shows value of dynamical systems approach for developmental phenomena
- Demonstrates power of simulation for theory development
- Bridges levels: Individual differences (psychometrics) explained by developmental processes (growth dynamics + interactions)

---

## Reading Log

| Date | Sections | Purpose |
|------|----------|---------|
| 2026-01-11 | Full paper | Extract source notes for tripartite architecture module; identify high IC/EC exemplar as contrast to ego depletion (low IC/EC) |

