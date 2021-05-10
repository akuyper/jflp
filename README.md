
# jflp

<!-- badges: start -->
<!-- badges: end -->

The goal of jflp is to create functions that allow a user to download an excel file from the Statistics Bureau of Japan, with all of its intricate and unique formatting, and read data into RStudio with ease, without the original formatting providing a barrier to data analysis and visualizations. This function assumes that the file will meet the Japanese Bureau formatting of columns and rows for Tabulations IV-9 and IV-7 of the Labor Force Survey, which are datasets covering the years 2007 to 2019. This package was created during the course of my senior year thesis project on the impact of Japan's "Womenomics"  policies on gender equality in the workforce.


## Installation

In order to install package `jflp`, use the code below to install from Github:

``` r
devtools::install_github("akuyper/jflp")
```

This package requires downloading the excel file directly from the database onto your device. Direct access to Form IV-9 can be found on the Statistics of Japan database using this link: https://www.e-stat.go.jp/en/stat-search/files?page=1&query=Table%20IV-9%202019&layout=dataset&metadata=1&data=1. Direct access to form IV-7 can be found here: https://www.e-stat.go.jp/en/stat-search/files?page=1&query=table%20IV-7&layout=dataset&stat_infid=000032085217&metadata=1&data=1. Lastly, a link to all Basic Tabulations on relevant labor data from the Labor Force Survey, which are updated on a monthly basis, is: https://www.e-stat.go.jp/en/stat-search/files?page=1&layout=datalist&toukei=00200531&tstat=000000110001&cycle=1&year=20180&month=24101211&tclass1=000001040276&tclass2=000001040283&tclass3=000001040284&result_back=1&cycle_facet=tclass1%3Atclass2%3Atclass3%3Acycle&tclass4val=0. For other relevant forms, this code can be recreated by altering column names, but for the purposes of the scope of my thesis research, I focus specifically on these two tables. 

## Example

Below are basic examples showing how to utilize the functions from package `jflp` in order to solve a common problem when researching labor data in Japan: the excel files from the Japan Bureau database  have distinctive and troublesome formatting. The examples specifically utilize Tables IV-7 and IV-9 from the database and begin making preliminary graphical visualizations to illustrate the basic use of the functions. These specific examples are from the year 2019. 

``` r
library(jflp)


## basic example code

# example with IV-9

tidy_data_9 <- clean_IV_9(data = "inst/data/104090e.xls")

tidy_data_9

ggplot(data = tidy_data_9, aes(x = reorder(household_type, tot), y = tot, fill = household_type)) +
  geom_bar(stat = "identity", position = "dodge", width = .6) +
  scale_fill_manual(values = c("One-person household" = "#526b9c", "Mother-child household" = "dark grey", 
                               "Aged-person household" = "light blue"
 )) +
  labs(title= "Participation in Labor Force by Household Type",
       x = "Household Type",
       y =  "Number of Workers (tens of thousands)", 
       color = "Household Type", 
       fill = "Household Type") +
  theme_clean()


# example with IV-7
# visualizing employment status across Japan's agricultural industry for the year 2018 (excluding executive positions)

tidy_data_7 <- clean_IV_7(data = "inst/data/104070e.xls")

library(ggthemes)
library(ggplot2)

# plot 1 
ggplot(data = tidy_data_7, aes(x = emp_status, y = non_exec_ag, fill = emp_status))+
geom_bar(stat = "identity" , position = "dodge") +
  scale_fill_manual(values = c("slategray2", "royalblue", "#526b9c")) +
  scale_x_discrete(labels = c("Employed",
                              "Unemployed",
                              "Not in Labor Force"))+
  labs(title= "Employment Status Across Agricultural Industry in Japan in 2019 (non-executive positions)",
       x = "Employment Status",
       y =  "Number of Individuals (tens of thousands)", 
       color = "Employment Status", 
       fill = "Employment Status") +
  theme_clean()

# plot 2 
ggplot(data = tidy_data_7, aes(x = total_lab_force, y = non_ag_fw, fill = total_lab_force)) +
  geom_bar(stat = "identity" , position = "dodge") + 
  scale_fill_manual(values = c("slategray2", "royalblue")) +
  scale_x_discrete(labels = c("Labor Force",
                              "Not in Labor Force"))+
  labs(title= "Employment Status of Non-Agricultural Family Workers (2019)",
       x = "Employment Type",
       y =  "Number of Non-Agricultural Family Workers (tens of thousands)", 
       color = "Employment Type", 
       fill = "Employment Type") +
  theme_clean()




```

