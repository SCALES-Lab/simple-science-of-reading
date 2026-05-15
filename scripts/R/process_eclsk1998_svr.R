# ==============================================================================
# process_eclsk1998_svr.R
#
# Creates a processed ECLS-K:1998 parquet file for SVR-DD model calibration
#
# Input:  ~/Documents/data/ECLSK/eclsk1998_raw.parquet
# Output: ~/Documents/data/ECLSK/eclsk1998_processed.parquet
#
# Variables included:
#   - Achievement (reading, math, general knowledge, science)
#   - Reading proficiency levels and probability scores
#   - Demographics
#   - Teacher ratings (Spring K)
#   - Motor skills (Fall K)
#   - Age at each assessment wave (derived)
#
# Theoretical mappings to SVR-DD constructs:
#   - Reading scale scores (c*r4rscl) -> RC (Reading Comprehension)
#   - Reading proficiency levels -> D (Decoding proxy via mastery levels)
#   - General knowledge -> L (Language Comprehension proxy)
#   - Math scores -> control/comparison skill
#
# Wave mapping:
#   C1 = Fall K (1998-99)    C5 = Spring 3rd (2001-02)
#   C2 = Spring K (1998-99)  C6 = Spring 5th (2003-04)
#   C3 = Fall 1st (1999-00)  C7 = Spring 8th (2006-07)  [C3 EXCLUDED: 30% PSU subsample]
#   C4 = Spring 1st (1999-00)
#
# Author: SCALES Lab
# ==============================================================================

# Load required libraries
library(arrow)
library(dplyr)
library(cli)
library(here)

# Source utility functions
source(here::here("scripts/R/eclsk_io.R"))

# ==============================================================================
# VARIABLE DEFINITIONS
# ==============================================================================

# Wave abbreviations for clean output names (grade-based, self-documenting)
#   C1 = Fall K   → fk     C5 = Spring 3rd → s3
#   C2 = Spring K → sk     C6 = Spring 5th → s5
#   C4 = Spring 1st → s1   C7 = Spring 8th → s8
WAVE_MAP <- c("1" = "fk", "2" = "sk", "4" = "s1", "5" = "s3", "6" = "s5", "7" = "s8")

# Sequential wave index: wave abbreviation -> 1-6 (for long format and plotting)
WAVE_ORDER <- c(fk = 1, sk = 2, s1 = 3, s3 = 4, s5 = 5, s8 = 6)

# Human-readable wave labels
WAVE_LABELS <- c(
  fk = "Fall K",     sk = "Spring K",  s1 = "Spring 1st",
  s3 = "Spring 3rd", s5 = "Spring 5th", s8 = "Spring 8th"
)

# ID variable
id_var <- "childid"

# Achievement: Reading IRT scale scores (6 waves; C3/Fall 1st excluded)
reading_scales <- c("c1r4rscl", "c2r4rscl", "c4r4rscl",
                    "c5r4rscl", "c6r4rscl", "c7r4rscl")

# Achievement: Math IRT scale scores (6 waves; C3/Fall 1st excluded)
math_scales <- c("c1r4mscl", "c2r4mscl", "c4r4mscl",
                 "c5r4mscl", "c6r4mscl", "c7r4mscl")

# Achievement: General knowledge (C1, C2, C4 only; C3/Fall 1st excluded)
gk_scales <- c("c1rgscal", "c2rgscal", "c4rgscal")

# Achievement: Science (C5-C7 only: 3rd, 5th, 8th grade)
science_scales <- c("c5r2sscl", "c6r2sscl", "c7r2sscl")

# Reading proficiency: Highest level mastered (D proxy; C3/Fall 1st excluded)
reading_proficiency <- c("c1r4rpf", "c2r4rpf", "c4r4rpf",
                         "c5r4rpf", "c6r4rpf", "c7r4rpf")

# Math proficiency: Highest level mastered (comparison; C3/Fall 1st excluded)
math_proficiency <- c("c1r4mpf", "c2r4mpf", "c4r4mpf",
                      "c5r4mpf", "c6r4mpf", "c7r4mpf")

# Reading probability scores: 9 levels per wave (54 variables; C3/Fall 1st excluded)
# These provide fine-grained mastery probabilities for each skill level
reading_prob <- c(
  # Wave 1
  "c1r4rpb1", "c1r4rpb2", "c1r4rpb3", "c1r4rpb4", "c1r4rpb5",
  "c1r4rpb6", "c1r4rpb7", "c1r4rpb8", "c1r4rpb9",
  # Wave 2
  "c2r4rpb1", "c2r4rpb2", "c2r4rpb3", "c2r4rpb4", "c2r4rpb5",
  "c2r4rpb6", "c2r4rpb7", "c2r4rpb8", "c2r4rpb9",
  # Wave 4 (Wave 3/Fall 1st excluded)
  "c4r4rpb1", "c4r4rpb2", "c4r4rpb3", "c4r4rpb4", "c4r4rpb5",
  "c4r4rpb6", "c4r4rpb7", "c4r4rpb8", "c4r4rpb9",
  # Wave 5
  "c5r4rpb1", "c5r4rpb2", "c5r4rpb3", "c5r4rpb4", "c5r4rpb5",
  "c5r4rpb6", "c5r4rpb7", "c5r4rpb8", "c5r4rpb9",
  # Wave 6
  "c6r4rpb1", "c6r4rpb2", "c6r4rpb3", "c6r4rpb4", "c6r4rpb5",
  "c6r4rpb6", "c6r4rpb7", "c6r4rpb8", "c6r4rpb9",
  # Wave 7
  "c7r4rpb1", "c7r4rpb2", "c7r4rpb3", "c7r4rpb4", "c7r4rpb5",
  "c7r4rpb6", "c7r4rpb7", "c7r4rpb8", "c7r4rpb9"
)

# Date of birth components
dob_vars <- c("dobyy", "dobmm", "dobdd")

# Assessment date components for each wave (for age computation)
assess_year_vars <- c("c1asmtyy", "c2asmtyy", "c4asmtyy",
                      "c5asmtyy", "c6asmtyy", "c7asmtyy")
assess_month_vars <- c("c1asmtmm", "c2asmtmm", "c4asmtmm",
                       "c5asmtmm", "c6asmtmm", "c7asmtmm")
assess_day_vars <- c("c1asmtdd", "c2asmtdd", "c4asmtdd",
                     "c5asmtdd", "c6asmtdd", "c7asmtdd")

# Demographics
demo_vars <- c(
  "gender",     # 1=Male, 2=Female
  "race",       # Multi-category race/ethnicity
  "p1firkdg",   # First-time kindergartener
  "p1hparnt",   # Household parent type
  "p1hmage",    # Mother's age at child's birth
  "wkmomed",    # Mother's education level
  "wkdaded",    # Father's education level
  "wkincome",   # Family income (imputed)
  "p1numsib"    # Number of siblings
)

# Teacher ratings (Spring K only)
teacher_vars <- c(
  "t2learn",    # Approaches to learning
  "t2contro",   # Self-control
  "t2interp",   # Interpersonal skills
  "t2extern",   # Externalizing behaviors
  "t2intern"    # Internalizing behaviors
)

# Motor skills (Fall K only)
motor_vars <- c("c1fmotor", "c1gmotor")

# ==============================================================================
# VARIABLE RENAME MAP
# ==============================================================================

#' Build the complete old-name → new-name rename map for processed variables
#' @return Named character vector: names are old raw names, values are clean names
build_rename_map <- function() {
  waves <- names(WAVE_MAP)  # "1","2","4","5","6","7"
  abbrs <- unname(WAVE_MAP)  # "fk","sk","s1","s3","s5","s8"

  # Helper: build map for a set of raw names and a set of new names (same length)
  pair <- function(old, new) setNames(new, old)

  # Achievement: reading IRT scale scores
  read_map <- pair(
    paste0("c", waves, "r4rscl"),
    paste0("read_", abbrs)
  )

  # Achievement: math IRT scale scores
  math_map <- pair(
    paste0("c", waves, "r4mscl"),
    paste0("math_", abbrs)
  )

  # Achievement: general knowledge (waves 1,2,4 only)
  gk_waves <- c("1", "2", "4")
  gk_abbrs <- WAVE_MAP[gk_waves]
  gk_map <- pair(
    paste0("c", gk_waves, "rgscal"),
    paste0("gk_", gk_abbrs)
  )

  # Achievement: science (waves 5,6,7 only)
  sci_waves <- c("5", "6", "7")
  sci_abbrs <- WAVE_MAP[sci_waves]
  sci_map <- pair(
    paste0("c", sci_waves, "r2sscl"),
    paste0("sci_", sci_abbrs)
  )

  # Reading proficiency levels (D proxy)
  rdpf_map <- pair(
    paste0("c", waves, "r4rpf"),
    paste0("rdpf_", abbrs)
  )

  # Math proficiency levels
  mthpf_map <- pair(
    paste0("c", waves, "r4mpf"),
    paste0("mthpf_", abbrs)
  )

  # Reading probability scores (levels 1-9 × 6 waves = 54 vars)
  rdprob_map <- do.call(c, lapply(seq_along(waves), function(i) {
    pair(
      paste0("c", waves[i], "r4rpb", 1:9),
      paste0("rdprob", 1:9, "_", abbrs[i])
    )
  }))

  # Age at assessment (derived)
  age_map <- pair(
    paste0("age_c", waves),
    paste0("age_", abbrs)
  )

  # Date of birth components
  dob_map <- pair(
    c("dobyy", "dobmm", "dobdd"),
    c("dob_year", "dob_month", "dob_day")
  )

  # Assessment date components (year, month, day × 6 waves = 18 vars)
  asmt_yr_map  <- pair(paste0("c", waves, "asmtyy"), paste0("asmt_year_",  abbrs))
  asmt_mo_map  <- pair(paste0("c", waves, "asmtmm"), paste0("asmt_month_", abbrs))
  asmt_day_map <- pair(paste0("c", waves, "asmtdd"), paste0("asmt_day_",   abbrs))

  # Demographics
  demo_map <- pair(
    c("p1firkdg", "p1hparnt", "p1hmage", "wkmomed", "wkdaded", "wkincome", "p1numsib"),
    c("first_kg", "hh_parent", "mom_age", "mom_ed",  "dad_ed",  "fam_income", "n_sibs")
  )

  # Teacher ratings (Spring K only — no wave suffix needed; all are wave 2)
  teacher_map <- pair(
    c("t2learn", "t2contro", "t2interp", "t2extern", "t2intern"),
    c("tchr_learn", "tchr_ctrl", "tchr_interp", "tchr_extern", "tchr_intern")
  )

  # Motor skills (Fall K only — no wave suffix needed; both are wave 1)
  motor_map <- pair(
    c("c1fmotor", "c1gmotor"),
    c("fine_motor", "gross_motor")
  )

  # Combine all (gender and race keep their names; childid keeps its name)
  c(read_map, math_map, gk_map, sci_map,
    rdpf_map, mthpf_map, rdprob_map,
    age_map, dob_map,
    asmt_yr_map, asmt_mo_map, asmt_day_map,
    demo_map, teacher_map, motor_map)
}

#' Rename processed variables to clean, self-documenting names
#' @param df Processed dataframe with raw NCES variable names
#' @param rename_map Named character vector from build_rename_map()
#' @return Dataframe with renamed columns
rename_processed_variables <- function(df, rename_map) {
  # Only rename variables that actually exist in the data
  in_data    <- intersect(names(rename_map), names(df))
  not_mapped <- setdiff(names(df), c(names(rename_map), "childid", "gender", "race"))
  if (length(not_mapped) > 0) {
    cli::cli_warn("No rename mapping for {length(not_mapped)} variable(s): {head(not_mapped, 5)}")
  }
  df %>% dplyr::rename(!!!setNames(in_data, rename_map[in_data]))
}

# ==============================================================================
# PROCESSING FUNCTIONS
# ==============================================================================

#' Select SVR-DD relevant variables from raw data
#' @param df Raw ECLS-K:1998 dataframe
#' @return Dataframe with selected variables only
select_svr_variables <- function(df) {
  # Combine all variable lists
  all_vars <- c(
    id_var,
    reading_scales,
    math_scales,
    gk_scales,
    science_scales,
    reading_proficiency,
    math_proficiency,
    reading_prob,
    dob_vars,
    assess_year_vars,
    assess_month_vars,
    assess_day_vars,
    demo_vars,
    teacher_vars,
    motor_vars
  )

  # Check which variables exist (names are already lowercase from eclsk_read)
  existing_vars <- intersect(all_vars, names(df))
  missing_vars <- setdiff(all_vars, names(df))

  if (length(missing_vars) > 0) {
    cli::cli_warn("Missing {length(missing_vars)} variables: {head(missing_vars, 10)}")
    if (length(missing_vars) > 10) {
      cli::cli_warn("... and {length(missing_vars) - 10} more")
    }
  }

  cli::cli_alert_info("Selecting {length(existing_vars)} of {length(all_vars)} requested variables")

  df %>% select(all_of(existing_vars))
}

#' Compute age in months at each assessment wave
#' @param df Dataframe with DOB and assessment date components
#' @return Dataframe with added age_c1 through age_c7 columns
compute_wave_ages <- function(df) {
  # Build DOB once
  df <- df %>%
    mutate(
      dob = build_date(dobyy, dobmm, dobdd)
    )

  # Compute age at each wave (wave 3/Fall 1st excluded)
  for (wave in c(1, 2, 4, 5, 6, 7)) {
    year_var <- paste0("c", wave, "asmtyy")
    month_var <- paste0("c", wave, "asmtmm")
    day_var <- paste0("c", wave, "asmtdd")
    age_var <- paste0("age_c", wave)

    if (all(c(year_var, month_var, day_var) %in% names(df))) {
      df <- df %>%
        mutate(
          !!age_var := compute_age_months(
            dob,
            build_date(.data[[year_var]], .data[[month_var]], .data[[day_var]])
          )
        )
    } else {
      cli::cli_warn("Missing assessment date components for wave {wave}")
    }
  }

  # Remove intermediate dob column
  df <- df %>% select(-dob)

  df
}

#' Validate processed data quality
#' @param df Processed dataframe
#' @return TRUE if all checks pass, FALSE otherwise
validate_processed_data <- function(df) {
  checks <- list()

  # Check 1: No duplicate IDs
  checks$unique_ids <- n_distinct(df$childid) == nrow(df)

  # Check 2: Reading scores are in plausible range (0-250 based on IRT scaling)
  reading_cols <- grep("^read_(fk|sk|s1|s3|s5|s8)$", names(df), value = TRUE)
  if (length(reading_cols) > 0) {
    checks$reading_range <- all(sapply(df[reading_cols], function(x) {
      all(is.na(x) | (x >= 0 & x <= 250))
    }))
  } else {
    checks$reading_range <- TRUE
  }

  # Check 3: Ages are plausible (40-200 months for K-8th grade)
  # Wave 7 is 8th grade (~14-15 years old = 168-184 months)
  age_cols <- grep("^age_(fk|sk|s1|s3|s5|s8)$", names(df), value = TRUE)
  if (length(age_cols) > 0) {
    checks$age_range <- all(sapply(df[age_cols], function(x) {
      all(is.na(x) | (x >= 40 & x <= 200))
    }))
  } else {
    checks$age_range <- TRUE
  }

  # Check 4: Proficiency levels are 0-10 (ECLS-K:1998 uses 10 levels)
  prof_cols <- grep("^rdpf_(fk|sk|s1|s3|s5|s8)$", names(df), value = TRUE)
  if (length(prof_cols) > 0) {
    checks$prof_range <- all(sapply(df[prof_cols], function(x) {
      all(is.na(x) | (x >= 0 & x <= 10))
    }))
  } else {
    checks$prof_range <- TRUE
  }

  # Check 5: Probability scores are 0-1
  prob_cols <- grep("^rdprob[1-9]_(fk|sk|s1|s3|s5|s8)$", names(df), value = TRUE)
  if (length(prob_cols) > 0) {
    checks$prob_range <- all(sapply(df[prob_cols], function(x) {
      all(is.na(x) | (x >= 0 & x <= 1))
    }))
  } else {
    checks$prob_range <- TRUE
  }

  # Report results
  cli::cli_h2("Validation Results")
  for (name in names(checks)) {
    status <- if (checks[[name]]) cli::col_green("PASS") else cli::col_red("FAIL")
    cli::cli_alert_info("{name}: {status}")
  }

  all(unlist(checks))
}

#' Print summary statistics for processed data
#' @param df Processed dataframe
summarize_processed_data <- function(df) {
  cli::cli_h2("Processed Data Summary")
  cli::cli_alert_info("Observations: {format(nrow(df), big.mark = ',')}")
  cli::cli_alert_info("Variables: {ncol(df)}")

  # Achievement coverage by wave
  reading_cols <- grep("^read_(fk|sk|s1|s3|s5|s8)$", names(df), value = TRUE)
  if (length(reading_cols) > 0) {
    coverage <- sapply(reading_cols, function(x) sum(!is.na(df[[x]])))
    cli::cli_alert_info("Reading coverage by wave:")
    for (i in seq_along(coverage)) {
      cli::cli_alert_info("  {names(coverage)[i]}: {format(coverage[i], big.mark = ',')}")
    }
  }

  # Age range summary
  age_cols <- grep("^age_(fk|sk|s1|s3|s5|s8)$", names(df), value = TRUE)
  if (length(age_cols) > 0) {
    cli::cli_alert_info("Age ranges (months):")
    for (col in age_cols) {
      rng <- range(df[[col]], na.rm = TRUE)
      cli::cli_alert_info("  {col}: {round(rng[1], 1)} - {round(rng[2], 1)}")
    }
  }
}

# ==============================================================================
# FACTOR CONVERSION
# ==============================================================================

#' Convert categorical variables to properly-typed R factors
#'
#' Applied after variable renaming so clean names (gender, race, etc.) are used.
#' R factors round-trip correctly through parquet (Arrow dictionary encoding)
#' and are handled natively by haven::write_sav() for SPSS export.
#'
#' Variables converted:
#'   Nominal:  gender, race, first_kg, hh_parent
#'   Ordinal:  mom_ed, dad_ed
#'
#' Variables intentionally kept numeric:
#'   rdpf_*, mthpf_* - proficiency levels used in arithmetic (gains, means, correlations)
#'
#' @param df Processed dataframe with renamed clean variable names
#' @return Dataframe with factor-typed categorical columns
factorize_eclsk_variables <- function(df) {
  ed_levels <- c("Less than HS", "HS diploma/GED", "Some college",
                 "Bachelor's", "Graduate degree")

  # Gender (nominal: 1=Male, 2=Female)
  if ("gender" %in% names(df)) {
    df <- df %>%
      dplyr::mutate(
        gender = factor(gender, levels = 1:2, labels = c("Male", "Female"))
      )
  }

  # Race/ethnicity (nominal)
  # Codes 1-4 mapped individually; codes >=5 collapsed to "Other"
  # (consistent with 03-eda-eclsk1998-predictors.qmd; additional codes
  #  5-8 are not individually documented in available codebook excerpts)
  if ("race" %in% names(df)) {
    df <- df %>%
      dplyr::mutate(
        race = factor(
          dplyr::case_when(
            race == 1 ~ "White",
            race == 2 ~ "Black or African American",
            race == 3 ~ "Hispanic",
            race == 4 ~ "Asian",
            !is.na(race) ~ "Other",
            TRUE ~ NA_character_
          ),
          levels = c("White", "Black or African American",
                     "Hispanic", "Asian", "Other")
        )
      )
  }

  # First-time kindergartener status (nominal: 1=First-time K, 2=Repeat K)
  if ("first_kg" %in% names(df)) {
    df <- df %>%
      dplyr::mutate(
        first_kg = factor(first_kg, levels = 1:2,
                          labels = c("First-time K", "Repeat K"))
      )
  }

  # Household parent type (nominal, 9 levels; source: ECLS-K:1998 P1HPARNT codebook)
  if ("hh_parent" %in% names(df)) {
    df <- df %>%
      dplyr::mutate(
        hh_parent = factor(
          hh_parent, levels = 1:9,
          labels = c(
            "Bio mother & bio father",
            "Bio mother & other father",
            "Bio father & other mother",
            "Bio mother only",
            "Bio father only",
            "Two adoptive parents",
            "Adoptive/stepparent",
            "Related guardian(s)",
            "Unrelated guardian(s)"
          )
        )
      )
  }

  # Mother's education (ordinal: 1=lowest, 5=highest)
  if ("mom_ed" %in% names(df)) {
    df <- df %>%
      dplyr::mutate(
        mom_ed = factor(mom_ed, levels = 1:5, labels = ed_levels, ordered = TRUE)
      )
  }

  # Father's education (ordinal: same encoding as mother's)
  if ("dad_ed" %in% names(df)) {
    df <- df %>%
      dplyr::mutate(
        dad_ed = factor(dad_ed, levels = 1:5, labels = ed_levels, ordered = TRUE)
      )
  }

  df
}

# ==============================================================================
# LONG FORMAT PIVOT
# ==============================================================================

#' Pivot wide processed 1998 data to a single long achievement dataframe.
#'
#' Output columns:
#'   childid, subject, wave, wave_index, wave_label, score, age_months,
#'   gender, race, fam_income, mom_ed
#'
#' All four achievement subjects (reading, math, general_knowledge, science)
#' are stacked with a `subject` column. Rows with NA scores are retained so
#' that subject × wave coverage is explicit (e.g. gk is waves 1-3 only,
#' science is waves 4-6 only).
#'
#' @param df Processed wide dataframe (output of factorize_eclsk_variables)
#' @return Long dataframe ordered by childid, subject, wave_index
pivot_1998_to_long <- function(df) {
  demo_cols <- intersect(
    c("gender", "race", "fam_income", "mom_ed"),
    names(df)
  )

  pivot_subject <- function(prefix, label) {
    pivot_processed_long(df, prefix, id_var = id_var,
                         subject = label, wave_order = WAVE_ORDER)
  }

  subjects <- dplyr::bind_rows(
    pivot_subject("read", "reading"),
    pivot_subject("math", "math"),
    pivot_subject("gk",   "general_knowledge"),
    pivot_subject("sci",  "science")
  ) %>%
    dplyr::mutate(wave_label = unname(WAVE_LABELS[wave]))

  # Age at each wave (pivot age_ columns using the same helper)
  age_long <- pivot_processed_long(df, "age", id_var = id_var,
                                    subject = "age", wave_order = WAVE_ORDER) %>%
    dplyr::select(dplyr::all_of(id_var), wave, age_months = score)

  # Demographics (time-invariant; repeated for every subject × wave row)
  demo_df <- df %>% dplyr::select(dplyr::all_of(id_var), dplyr::all_of(demo_cols))

  subjects %>%
    dplyr::left_join(age_long, by = c(id_var, "wave")) %>%
    dplyr::left_join(demo_df,  by = id_var) %>%
    dplyr::select(dplyr::all_of(id_var), subject, wave, wave_index, wave_label,
                  score, age_months, dplyr::all_of(demo_cols)) %>%
    dplyr::arrange(dplyr::all_of(id_var), subject, wave_index)
}

# ==============================================================================
# MAIN PROCESSING PIPELINE
# ==============================================================================

main <- function() {
  # Configuration
  input_path       <- "~/Documents/data/ECLSK/eclsk1998_raw.parquet"
  output_path      <- "~/Documents/data/ECLSK/eclsk1998_processed.parquet"
  long_output_path <- "~/Documents/data/ECLSK/eclsk1998_long.parquet"

  cli::cli_h1("Processing ECLS-K:1998 for SVR-DD Models")

  # Step 1: Read raw data
  cli::cli_alert_info("Reading raw data from {input_path}")
  df_raw <- eclsk_read(input_path)
  cli::cli_alert_success("Loaded {format(nrow(df_raw), big.mark = ',')} observations, {ncol(df_raw)} variables")

  # Step 2: Clean missing values
  cli::cli_alert_info("Cleaning missing value codes (-1, -4, -7, -8, -9 -> NA)")
  df_clean <- clean_eclsk_generic(df_raw)

  # Step 3: Select variables
  cli::cli_alert_info("Selecting SVR-DD relevant variables")
  df_selected <- select_svr_variables(df_clean)
  cli::cli_alert_success("Selected {ncol(df_selected)} variables")

  # Step 4: Compute derived variables
  cli::cli_alert_info("Computing age at each assessment wave")
  df_derived <- compute_wave_ages(df_selected)
  cli::cli_alert_success("Added {sum(grepl('^age_c[1-7]$', names(df_derived)))} age variables (pre-rename)")

  # Step 4b: Rename variables to clean, self-documenting names
  cli::cli_alert_info("Renaming variables to clean names ({{domain}}_{{wave}} pattern)")
  rename_map <- build_rename_map()
  df_renamed <- rename_processed_variables(df_derived, rename_map)
  cli::cli_alert_success("Variables renamed ({ncol(df_renamed)} total)")

  # Step 4c: Convert categorical variables to factors
  cli::cli_alert_info("Converting categorical variables to factors")
  df_factored <- factorize_eclsk_variables(df_renamed)
  cli::cli_alert_success("Factor conversions applied (gender, race, first_kg, hh_parent, mom_ed, dad_ed)")

  # Step 5: Validate
  cli::cli_alert_info("Validating processed data")
  valid <- validate_processed_data(df_factored)

  if (!valid) {
    cli::cli_abort("Validation failed. Check data quality before proceeding.")
  }

  # Step 6: Summary
  summarize_processed_data(df_factored)

  # Step 7: Write wide output
  cli::cli_alert_info("Writing wide processed data to {output_path}")
  write_parquet_overwrite(df_factored, output_path)

  if (file.exists(output_path)) {
    size_mb <- file.info(output_path)$size / 1024^2
    cli::cli_alert_success("Wide file written ({round(size_mb, 1)} MB): {output_path}")
  } else {
    cli::cli_abort("Failed to write wide output file")
  }

  # Step 8: Pivot to long format and write
  cli::cli_alert_info("Pivoting to long format (reading + math + general_knowledge + science stacked)")
  df_long <- pivot_1998_to_long(df_factored)
  cli::cli_alert_success(
    "Long format: {format(nrow(df_long), big.mark = ',')} rows x {ncol(df_long)} columns"
  )

  cli::cli_alert_info("Writing long data to {long_output_path}")
  write_parquet_overwrite(df_long, long_output_path)

  if (file.exists(long_output_path)) {
    size_mb <- file.info(long_output_path)$size / 1024^2
    cli::cli_alert_success("Long file written ({round(size_mb, 1)} MB): {long_output_path}")
  } else {
    cli::cli_abort("Failed to write long output file")
  }

  invisible(list(wide = df_factored, long = df_long))
}

# Run if called directly
if (sys.nframe() == 0) {
  main()
}
