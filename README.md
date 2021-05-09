
# jflp

<!-- badges: start -->
<!-- badges: end -->

The goal of jflp is to create a function that allows a user to download an excel file from the Statistics Bureau of Japan, with all of its intricate and unique formatting, and read data into RStudio with ease, without the original formatting providing a barrier to data analysis and visualizations. This function assumes that the file will meet the Japanese Bureau formatting of columns and rows for Tabulation IV-9 for the Years 2007 to 2019. 


## Installation

In order to install package `jflp`, use the code below to install from Github:

``` r
devtools::install_github("akuyper/jflp")
```

## Example

This is a basic example which shows you how to solve a common problem: downloading an excel file that has Japanese government-specific formatting. 

``` r
library(jflp)
## basic example code

clean_dat(path = "~/Documents/Quarter 1, Year 4/STAT 399 - Honors Thesis/Data/Statistics Bureau of Japan/IV-9/2019_Original.xls", na = c("-"))

```

