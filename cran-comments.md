
## Test environment
* local Fedora Linux Mint 18.1 Serena Xfce 64-bit OS, R version 4.0.3
* win-builder
* R-hub builder: Windows Server 2008 R2 SP1, 32/64 bit; Ubuntu Linux 16.04 LTS, R-release, GCC; Fedora Linux, R-devel, clang, gfortran
* Travis CI

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* checking for future file timestamps ... NOTE
  unable to verify current time

    EXPLANATION: Flexible time zone on local OS. Has no implications for package usability.


## R-hub builder results
There were no ERRORs or WARNINGs. 

There were 2 NOTES:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Christoph Dworschak <c.dworschak@essex.ac.uk>'

New submission

Possibly mis-spelled words in DESCRIPTION:
  ACLED (2:31, 12:137)
  ACLED's (12:237)

   EXPLANATION: Words are data set names, no misspelling.


* checking for future file timestamps ... NOTE
unable to verify current time

    EXPLANATION: Flexible time zone on local OS. Has no implications for package usability.



## Downstream dependencies
There are currently no downstream dependencies for this package.

