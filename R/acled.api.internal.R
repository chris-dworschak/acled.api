
.onAttach <-
  function(libname, pkgname) {
    packageStartupMessage("\nThe data must be cited as per ACLED attribution requirements. By using this package, you ")
    packageStartupMessage("acknowledge that you have read ACLED's terms and conditions. \n")
    packageStartupMessage("The package may be cited as:")
    packageStartupMessage('Dworschak, Christoph. 2020. "Acled.api: Automated Retrieval of ACLED Conflict Event Data."')
    packageStartupMessage("R package version 1.0.1. <https://github.com/chris-dworschak/acled.api/> \n")
  }
