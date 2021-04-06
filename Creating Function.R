## Creating a function for cleaning data from Statistics Bureau of Statistics
# Form IV-9

# Install
# version of R is 1.4.1106
# data.table (>= 1.4.1106),
# readxl,
# janitor,
# tidyverse


# load data from Statistics Bureau of Japan, IV-9 Tablulation

library(tidyverse)
library(readxl)
library(janitor)

cleandat = function(data){
  code_book <- tribble(
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
    "non_ag_enf", "total one-person households, in-labor force, non-agricultural industries, employee(self-employed)",
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
  read_xls(
    path = data,
    range = "H17:L62",
    col_names = FALSE,
    na = c("-")) %>%
    clean_names() %>%
    fill(x1) %>%
    mutate(x1 = if_else(is.na(x1), "One-person household", x1),
           x2 = case_when(
             row_number() < 12 ~ "Both sexes",
             row_number() < 23 ~ "Male",
             row_number() < 34 ~ "Female"),
           x4 = if_else(is.na(x5), x4, x5),
           x4 = if_else(is.na(x3) | (x3 %in% c("Male", "Female")), x4, x3),
           x4 = if_else(is.na(x4), "All ages", x4)
    ) %>%
    select(-x3, -x5) %>%
    rename(
      household_type = x1,
      sex_grouping = x2,
      age_grouping = x4)%>%
    bind_cols(
      read_xls(
        path = data,
        range = "N17:AH62",
        col_names = code_book %>% pull(var_code),
        na = c("-")
      )
    )
}

data_tst <- cleandat("2019_Original.xls")


#\name{jflp}
#\alias{jflp}
#\title{Organize Labor Data}
#\usage{
#  jflp(infile)
#}
#\arguments{
# \item{infile}{Path to the input file}
#}
#\value{
#  A matrix of the infile
#}
#\description{
 # This function downloading an excel file that has Japanese government-specific formatting.
 # This function provides code for a user to download an excel file from the Bureau and read
 # data into RStudio with ease, without original formatting providing a barrier to data analysis and visualizations.
# }

# to add package to my R library
devtools::install(jflp)

library("jflp")

devtools::install_github("manycarter/jflp")
