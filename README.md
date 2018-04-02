
Teaching Culture Perception Survey (TCPS) Project
=================================================

The goal of tcps package is to provide functionality to tidy and visualize the results of running the teaching culture perception survey at an institution.

Installation
------------

You can install tcps from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("jkaupp/tcps")
```

Using this package
------------------

At this point, the survey data is provided to institutions by contacting the Project Committee. Data is provided to the instiution in the form of an SPSS file that contains all raw data, plus statistics and calculated levers. The `tidy_tcps` function would be used in this case to clean up the file for plotting and other downstream analysis. It is difficult to show here as the SPSS files are unavailble to be shared due to institutional ethics clearance.

However, to show the output for `tidy_tcps` and to illustrate the plotting functions, a simulated data set was created.

``` r
data("tcps_sample")

head(tcps_sample)
#>    survey part_num      scale assessteach brengage impteach infrastruct
#> 1 Faculty        1  agreement    2.842961 3.501976 4.077569    4.351114
#> 2 Faculty        1 importance    4.683073 2.782824 1.078799    1.912885
#> 3 Faculty        2  agreement    1.865897 1.715102 4.081929    2.144232
#> 4 Faculty        2 importance    1.635696 2.995010 1.264698    3.069599
#> 5 Faculty        3  agreement    3.096476 1.360958 1.382166    2.293748
#> 6 Faculty        3 importance    4.267208 1.026790 4.978651    1.882372
#>   instinit teachrec Q6 Q7 Q8 Q9 Q10 Q11 Q12 Q13 Q14 Q15 Q16 Q17 Q18 Q19
#> 1 3.026214 2.354626  1  3  3  3   3   4   4   1   4   4   2   1   2   4
#> 2 1.957079 4.741554  1  2  1  3   4   2   4   1   3   1   3   3   2   1
#> 3 3.358587 2.166733  3  1  3  3   1   2   1   3   2   4   1   3   4   4
#> 4 2.389345 4.519164  2  1  2  1   4   1   1   4   4   4   3   3   2   2
#> 5 3.910978 4.392018  3  4  2  3   2   2   2   4   1   1   3   3   1   1
#> 6 4.630297 4.107326  3  4  1  3   2   2   1   1   2   1   2   3   1   4
#>   Q20 Q21 Q22 Q23 Q24 Q25 Q26 Q27 Q28 Q29 Q30 Q31 Q32 Q33 Q34 Q35 Q36 Q37
#> 1   3   2   4   2   2   1   4   2   1   3   1   1   1   4   4   2   4   1
#> 2   2   1   3   1   1   3   4   4   1   3   1   2   2   3   3   3   3   4
#> 3   3   4   2   3   4   1   1   4   2   4   3   3   4   3   4   4   4   1
#> 4   3   3   4   1   1   3   3   1   4   4   1   1   3   2   2   1   3   2
#> 5   2   3   1   4   4   4   2   1   1   2   2   3   2   2   2   2   4   4
#> 6   1   1   2   1   1   3   2   3   1   3   1   3   2   2   1   2   4   2
#>   Q38 Q39 Q40 Q41 Q42
#> 1   1   3   1   4   4
#> 2   2   4   3   4   3
#> 3   1   3   3   2   1
#> 4   1   2   3   4   4
#> 5   3   2   3   2   4
#> 6   3   1   3   4   3
```
