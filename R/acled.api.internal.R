
.onAttach <-
  function(libname, pkgname) {
    packageStartupMessage("\n Before using this package to download data, you require an ACLED access key.")
    packageStartupMessage("You can request your key by registering with ACLED on https://developer.acleddata.com/. \n")
    packageStartupMessage("The package may be cited as:")
    packageStartupMessage('Dworschak, Christoph. 2020. "Acled.api: Automated Retrieval of ACLED Conflict ')
    packageStartupMessage('Event Data." R package. CRAN version 1.1.8. \n')
    packageStartupMessage("For the development version of this package, visit <https://gitlab.com/chris-dworschak/acled.api/> \n")
  }

