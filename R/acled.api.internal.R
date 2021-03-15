
.onAttach <-
  function(libname, pkgname) {
    packageStartupMessage("\nBy using this package, you acknowledge that you have read ACLED's terms and")
    packageStartupMessage("conditions. The data must be cited as per ACLED attribution requirements. To")
    packageStartupMessage("download ACLED data, you require an ACLED access key. You can request your key")
    packageStartupMessage("by freely registering with ACLED on https://developer.acleddata.com/. \n")
    packageStartupMessage("The package may be cited as:")
    packageStartupMessage('Dworschak, Christoph. 2020. "Acled.api: Automated Retrieval of ACLED Conflict ')
    packageStartupMessage('Event Data." R package. CRAN version 1.1.3. \n')
    packageStartupMessage("For the development version of this package, visit <https://gitlab.com/chris-dworschak/acled.api/> \n")
  }

