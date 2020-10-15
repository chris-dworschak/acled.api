
.onAttach <-
  function(libname, pkgname) {
    packageStartupMessage("\nBy using this package, you acknowledge that you have read ACLED's terms")
    packageStartupMessage("and conditions. The data must be cited as per ACLED attribution requirements. \n")
    packageStartupMessage("The package may be cited as:")
    packageStartupMessage('Dworschak, Christoph. 2020. "Acled.api: Automated Retrieval of ACLED Conflict ')
    packageStartupMessage('Event Data." R package. CRAN version 1.0.7. \n')
    packageStartupMessage("For the development version of this package, visit <https://github.com/chris-dworschak/acled.api/> \n")
  }

