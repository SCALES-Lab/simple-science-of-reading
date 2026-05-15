# code/R/eclsk_io.R
# Functions for reading and processing ECLS-K data

# Read ECLSK data from various formats
eclsk_read <- function(path) {
  ext <- tolower(tools::file_ext(path))
  out <- switch(
    ext,
    "parquet" = arrow::read_parquet(path),
    "sav" = haven::read_sav(path),
    "dta" = haven::read_dta(path),
    "csv" = readr::read_csv(path, guess_max = 100000, progress = FALSE),
    stop("Unsupported file extension: ", ext)
  )
  janitor::clean_names(out)
}

# Helper operator for NULL coalescing
`%||%` <- function(a, b) if (!is.null(a)) a else b

# Compute age in months from date of birth and assessment date
compute_age_months <- function(dob, assess_date) {
  # Convert to Date if needed
  if (is.character(dob)) {
    dob <- tryCatch(as.Date(dob), error = function(e) as.Date(dob, format = "%Y-%m-%d"))
  }
  if (is.character(assess_date)) {
    assess_date <- tryCatch(as.Date(assess_date), error = function(e) as.Date(assess_date, format = "%Y-%m-%d"))
  }

  # Check if conversion succeeded
  if (!inherits(dob, "Date") || !inherits(assess_date, "Date")) {
    return(rep(NA_real_, length(dob)))
  }

  # Handle NA values
  if (all(is.na(dob)) || all(is.na(assess_date))) {
    return(rep(NA_real_, length(dob)))
  }

  # Compute age in months
  suppressWarnings({
    days_diff <- as.numeric(difftime(assess_date, dob, units = "days"))
    floor(days_diff / 30.4375)  # Average days per month
  })
}

# Build date from year, month, day components
build_date <- function(y, m, d) {
  # Convert inputs to integers, handling NAs
  y_int <- suppressWarnings(as.integer(y))
  m_int <- suppressWarnings(as.integer(m))
  d_int <- suppressWarnings(as.integer(d))

  # Create date strings
  date_str <- sprintf("%04d-%02d-%02d", y_int, m_int, d_int)

  # Convert to Date, returning NA for invalid dates
  suppressWarnings(as.Date(date_str, format = "%Y-%m-%d"))
}

# Clean ECLSK data - recode missing values to NA
clean_eclsk_generic <- function(df) {
  df <- janitor::clean_names(df)

  # Recode ECLS-K missing data codes to NA
  # ECLS-K uses negative values for various missing data reasons:
  # -1 = Not applicable, -4 = Data suppressed, -7 = Refused,
  # -8 = Don't know, -9 = Not ascertained
  df <- df %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.numeric), ~dplyr::na_if(., -1))) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.numeric), ~dplyr::na_if(., -4))) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.numeric), ~dplyr::na_if(., -7))) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.numeric), ~dplyr::na_if(., -8))) %>%
    dplyr::mutate(dplyr::across(dplyr::where(is.numeric), ~dplyr::na_if(., -9)))

  df
}

# Pivot scale scores from wide to long format
# Works for both ECLSK:2011 and ECLSK:1998
pivot_scales_long <- function(df, scale_vars, id_var = "childid", subject_label) {
  if (is.null(scale_vars) || !all(scale_vars %in% names(df))) return(NULL)

  out <- df %>%
    dplyr::select(dplyr::all_of(c(id_var, scale_vars))) %>%
    tidyr::pivot_longer(
      cols = dplyr::all_of(scale_vars),
      names_to = "wave_var",
      values_to = "score"
    ) %>%
    dplyr::mutate(
      # Extract wave index from variable names
      wave_index = as.integer(readr::parse_number(wave_var)),
      subject = subject_label
    )

  # Look for corresponding age variables
  age_pattern <- paste0("x", unique(out$wave_index), "age")
  age_vars <- age_pattern[age_pattern %in% names(df)]

  if (length(age_vars) > 0) {
    age_long <- df %>%
      dplyr::select(dplyr::all_of(c(id_var, age_vars))) %>%
      tidyr::pivot_longer(
        cols = dplyr::all_of(age_vars),
        names_to = "age_var",
        values_to = "age_months"
      ) %>%
      dplyr::mutate(
        wave_index = as.integer(readr::parse_number(age_var))
      ) %>%
      dplyr::select(dplyr::all_of(id_var), wave_index, age_months)

    out <- out %>%
      dplyr::left_join(age_long, by = c(id_var, "wave_index"))
  }

  out %>%
    dplyr::select(dplyr::all_of(id_var), subject, wave_index, score,
                  dplyr::any_of("age_months"))
}

# Convenience wrappers for reading and pivoting
read_eclsk_and_pivot <- function(path, reading_vars, math_vars,
                                  science_vars = NULL, gk_vars = NULL,
                                  age_vars = NULL, id_var = "childid") {
  # Read the data
  df <- eclsk_read(path)

  # Clean missing values
  df <- clean_eclsk_generic(df)

  # Pivot reading scores
  reading_long <- pivot_scales_long(df, reading_vars, id_var, "reading")

  # Pivot math scores
  math_long <- pivot_scales_long(df, math_vars, id_var, "math")

  # Pivot science scores (if provided)
  science_long <- if (!is.null(science_vars)) {
    pivot_scales_long(df, science_vars, id_var, "science")
  } else {
    NULL
  }

  # Pivot general knowledge scores (if provided)
  gk_long <- if (!is.null(gk_vars)) {
    pivot_scales_long(df, gk_vars, id_var, "general_knowledge")
  } else {
    NULL
  }

  # If age_vars provided, pivot those too
  age_long <- if (!is.null(age_vars)) {
    pivot_scales_long(df, age_vars, id_var, "age")
  } else {
    NULL
  }

  list(
    raw = df,
    reading_long = reading_long,
    math_long = math_long,
    science_long = science_long,
    gk_long = gk_long,
    age_long = age_long
  )
}

# Write parquet file, creating directory if needed
write_parquet_overwrite <- function(x, path) {
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  arrow::write_parquet(x, path)
  path
}

# Wave abbreviation -> wave index mapping for ECLS-K:2011 (9 waves)
# Override via the wave_order parameter in pivot_processed_long() for other cohorts.
ECLSK_WAVE_ORDER <- c(fk = 1, sk = 2, f1 = 3, s1 = 4, f2 = 5, s2 = 6, s3 = 7, s4 = 8, s5 = 9)

# Pivot processed ECLS-K data (clean {domain}_{wave_abbr} naming) to long format.
# Works with output of process_eclsk2011_svr.R and process_eclsk1998_svr.R.
#
# @param df         Processed wide dataframe
# @param prefix     Domain prefix, e.g. "read", "math", "sci", "age", "gk"
# @param id_var     ID column name (default "childid")
# @param subject    Label for the `subject` column in long output
# @param wave_order Named integer vector mapping wave abbreviation -> sequential index.
#                   Defaults to ECLSK_WAVE_ORDER (2011). Pass a cohort-specific map
#                   for other cohorts (e.g. 1998 uses c(fk=1,sk=2,s1=3,s3=4,s5=5,s8=6)).
# @return Long dataframe: id_var, subject, wave, wave_index, score
pivot_processed_long <- function(df, prefix, id_var = "childid", subject,
                                  wave_order = ECLSK_WAVE_ORDER) {
  abbr_pattern <- paste(names(wave_order), collapse = "|")
  col_pattern  <- paste0("^", prefix, "_(", abbr_pattern, ")$")
  cols         <- grep(col_pattern, names(df), value = TRUE)

  if (length(cols) == 0) return(NULL)

  df %>%
    dplyr::select(dplyr::all_of(c(id_var, cols))) %>%
    tidyr::pivot_longer(
      cols      = dplyr::all_of(cols),
      names_to  = "wave_var",
      values_to = "score"
    ) %>%
    dplyr::mutate(
      wave       = sub(paste0("^", prefix, "_"), "", wave_var),
      wave_index = unname(wave_order[wave]),
      subject    = subject
    ) %>%
    dplyr::select(dplyr::all_of(id_var), subject, wave, wave_index, score)
}

# Read processed ECLS-K parquet and pivot achievement subjects to long format.
# Expects the clean {domain}_{wave_abbr} naming produced by the processing scripts.
#
# @param path       Path to processed wide parquet file
# @param id_var     ID column name (default "childid")
# @param wave_order Named integer vector: wave abbreviation -> sequential index.
#                   Defaults to ECLSK_WAVE_ORDER (2011 cohort).
# @return List with $raw (wide), $reading_long, $math_long, $science_long
read_eclsk_processed_and_pivot <- function(path, id_var = "childid",
                                            wave_order = ECLSK_WAVE_ORDER) {
  df <- arrow::read_parquet(path)

  list(
    raw          = df,
    reading_long = pivot_processed_long(df, "read", id_var, "reading", wave_order),
    math_long    = pivot_processed_long(df, "math", id_var, "math",    wave_order),
    science_long = pivot_processed_long(df, "sci",  id_var, "science", wave_order)
  )
}
