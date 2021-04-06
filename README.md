
# jflp

<!-- badges: start -->
<!-- badges: end -->

The goal of jflp is to create a function that allows a user to download an excel file from the Statistics Bureau of Japan, with all of its intricate and unique formatting, and read data into RStudio with ease, without the original formatting providing a barrier to data analysis and visualizations.This function assumes that the file will meet the Japanese Bureau formatting of columns, namely G through AH and rows 3 through 15 for Tabulation IV-9 for the Years 2012 to 2019. From 2007 to 2012, the column and row names differ slightly than later files. 


## Installation

You can install the released version of jflp from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("jflp")
```

## Example

This is a basic example which shows you how to solve a common problem: downloading an excel file that has Japanese government-specific formatting. 

``` r
library(jflp)
## basic example code
```

