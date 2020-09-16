
.onAttach <-
  function(libname, pkgname) {
    packageStartupMessage("\nBy using this package, you acknowledge that you have read ACLED's terms")
    packageStartupMessage("and conditions. The data must be cited as per ACLED attribution requirements. \n")
    packageStartupMessage("The package may be cited as:")
    packageStartupMessage('Dworschak, Christoph. 2020. "Acled.api: Automated Retrieval of ACLED Conflict ')
    packageStartupMessage('Event Data." R package version 1.0.2. <https://github.com/chris-dworschak/acled.api/> \n')
  }
