#' Documentation for package ‘jflp’ version 0.0.0.9000 to read in Form IV-7
#'
#' @param bureau_7
#'
#' @return tidied dataset
#' @export
#'
#' @examples
clean_IV_7 <- function(data){
  # re-defining columns in excel file ----
  code_book <- tibble::tribble(
    ~ var_code, ~var_label,
    "tot", "total 1 = unemployed + employed + not in labor force",
    "t_lf", "total 2 = total in labor force = employed + unemployed",
    "t_emp", "total 3 = employed in labor force",
    "t_se", "total 4 = self-employed worker in labor force",
    "t_fw", "total 5 = family worker in labor force",
    "nf_emp",  "total 6 = non family employee in non-agricultural and agriculture & forestry industries",
    "non_exec_ag",  "total 7 = non family employee, non-executive",
    "nf_ag",  "total 8 = non family employee in agriculture",
    "non_ag", "total 9 = non family, non-agricultural employee",
    "non_ag_se",  "total 10 = non agricultural self-employed employer",
    "non_ag_fw", "total 11 = non-agricultural family worker",
    "non_ag_enf", "total 12 = non-agricultural industry employee",
    "non_ag_non_exec", "total 13 = non-agricultural industry employee, non-executive",
    "non_ag_not_at_work", "total 14 = non-agricultural employee not at work that reference week but receiving pay",
    "non_ag_14", "total 15 = husband in non-agricultural industries that work 1-14 hours per week",
    "non_ag_15_34", "total 16 = husband in non-agricultural industries that work 15-34 hours per week",
    "non_ag_29", "total 17 = husband in non-agricultural industries that work 15-29 hours per week",
    "non_ag_30_34", "total 18 = husband in non-agricultural industries that work 30-34 hours per week",
    "non_ag_35", "total 19 = husband in non-agricultural industries that works 35 hours per week or more",
    "non_ag_39", "total 20 = husband in non-agricultural industries that works 35-39 hours per week",
    "non_ag_48", "total 21 = husband in non-agricultural industries that works 40-48 hours per week",
    "non_ag_59", "total 22 = husband in non-agricultural industries that works 49-59 hours per week",
    "non_ag_60", "total 23 = husband in non-agricultural industries that works 60 hours or more per week",
    "non_ag_60_month", "total 24 = husband in non-agricultural industries that works 1 to 60 hours a month",
    "non_ag_120_month", "total 25 = husband in non-agricultural industries that works 61 to 120 hours a month",
    "non_ag_180_month", "total 26 = husband in non-agricultural industries that works 121 to 180 hours a month",
    "non_ag_240_month", "total 27 = husband in non-agricultural industries that works 181 to 240 hours a month",
    "non_ag_241_month", "total 28 = husband in non-agricultural industries that works 241 hours a month",
    "t_unemp", "unemployed people",
    "not_lf", "total not in labor force"
  )

  # read in excel file from Japan Stat. Bureau site, form IV-7 ----
  readxl::read_xls(
    path = data,
    range = "I17:O46",
    sheet = 1,
    col_names = FALSE,
    na = c("-")
  ) %>%
    janitor::clean_names() %>%
    tidyr::fill(x1) %>%
    dplyr::mutate(
      x1 = dplyr::case_when(
        dplyr::row_number() < 30 ~ "Labor Force",
        dplyr::row_number() < 31 ~ "Not in Labor Force"),
      x2 = dplyr::case_when(
        dplyr::row_number() < 29 ~ "Employed",
        dplyr::row_number() < 30 ~ "Unemployed",
        dplyr::row_number() < 31 ~ "Not in Labor Force"
      ),
      x4 = dplyr::if_else(is.na(x5), x4, x5),
      x4 = dplyr::if_else(is.na(x3) | (x3 %in% c("Employed", "Unemployed")), x4, x3),
      x4 = dplyr::if_else(is.na(x4), "Employed Person", x4),
      x6 = dplyr::if_else(is.na(x7) == TRUE, x6, x7),
    ) %>%
    dplyr::select(-x3, -x5, -x7) %>%
    # Renaming Column Names ----
  dplyr::rename(
    total_lab_force = x1,
    emp_status = x2,
    emp_type = x4,
    hours_type = x6
  ) %>%
    dplyr::bind_cols(
      readxl::read_xls(
        path = data,
        range = "Q17:AT46",
        col_names = code_book %>% dplyr::pull(var_code),
        na = c("-")
      )
    )
}

