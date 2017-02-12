# Does population density moderate the importance of information in intraspecies contests?}


## Installation
First install devtools:

```{r}
install.packages("devtools")
```
Then install the contest package:
```{r}
devtools::install_github("johnWilshire/contest")
```
Then instlal Remake:

To compile the paper we use [remake](https://github.com/traitecoevo/remake).  The easiest way to install remake is via [drat](https://github.com/eddelbuettel/drat):

```r
devtools::install_github("richfitz/remake")
```

Compilation requires a reasonably complete LaTeX installation (e.g. MacTeX).

We use the non-CRAN packages [callr](https://github.com/traitecoevo/callr).  This can be installed by remake:

```r
remake::install_missing_packages()
```

To compile everything, run

```r
remake::make()
```