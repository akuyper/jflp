#' Documentation for package ‘jflp’ version 0.0.0.9000 to read in Table IV-9
#'
#' @param bureau_9
#'
#' @return tidied dataset
#' @export
#'
#' @examples
clean_IV_9 <- function(data){

  # re-defining columns in excel file ----
  code_book <- tibble::tribble(
    ~ var_code, ~var_label,
    "tot", "total one-person households",
    "t_lf", "total one-person households, in-labor force",
    "t_emp", "total one-person households, in-labor force, employed",
    "t_se", "total one-person households, in-labor force, employed, self-employed",
    "t_fw", "total one-person households, in-labor force, employed, family worker",
    "nf_emp", "total one-person households, in-labor force, employed, employee (non-family)",
    "nf_ag", "total one-person households, in-labor force, employed, agricultural and forestry",
    "non_ag", "total one-person households, in-labor force, employed, non-agricultural industries",
    "non_ag_se", "total one-person households, in-labor force, non-agricultural industries, self-employed",
    "non_ag_fw", "total one-person households, in-labor force, non-agricultural industries, family worker",
    "non_ag_enf", "total one-person housetolds, in-labor force, non-agricultural industries, employee(self-employed)",
    "non_ag_14", "total one-person households, in-labor force, non-agricultural industries, 1-14 hours per week",
    "non_ag_15_34", "total one-person households, in-labor force, non-agricultural industries, 15-34 hours per week",
    "non_ag_29", "total one-person households, in-labor force, non-agricultural industries, 15-29 hours per week",
    "non_ag_30_34", "total one-person households, in-labor force, non-agricultural industries, 30-34 hours per week",
    "non_ag_35", "total one-person households, in-labor force, non-agricultural industries, 35 hours a week more more",
    "non_ag_39", "total one-person households, in-labor force, non-agricultural industries, 35-39 hours per week",
    "non_ag_48", "total one-person households, in-labor force, non-agricultural industries, 40-48 hours per week",
    "non_ag_49", "total one-person households, in-labor force, non-agricultural industries, 49 hours per week or more",
    "t_unemp", "total one-person households, in-labor force, unemployed persons",
    "not_lf", "total one-person households, in-labor force, not in labor force"
  )

  # read in excel file from Japan Stat. Bureau site, form IV-9 ----
  readxl::read_xls(
      path = data,
      range = "H17:L62",
      col_names = FALSE,
      na = c("-")
    ) %>%
    janitor::clean_names() %>%
    tidyr::fill(x1) %>%
    dplyr::mutate(
      x1 = dplyr::if_else(is.na(x1), "One-person household", x1),
      x2 = dplyr::case_when(
        dplyr::row_number() < 12 ~ "Both sexes",
        dplyr::row_number() < 23 ~ "Male",
        dplyr::row_number() < 34 ~ "Female"
        ),
      x4 = dplyr::if_else(is.na(x5), x4, x5),
      x4 = dplyr::if_else(is.na(x3) | (x3 %in% c("Male", "Female")), x4, x3),
      x4 = dplyr::if_else(is.na(x4), "All ages", x4)
    ) %>%
    dplyr::select(-x3, -x5) %>%
# Renaming Column Names ----
    dplyr::rename(
      household_type = x1,
      sex_grouping = x2,
      age_grouping = x4
      ) %>%
    dplyr::bind_cols(
     readxl::read_xls(
        path = data,
        range = "N17:AH62",
        col_names = code_book %>% dplyr::pull(var_code),
        na = c("-")
      )
    )
}






