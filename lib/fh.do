* 2015 Freedomhouse Freedom in the World Report
* https://freedomhouse.org/report/freedom-world/freedom-world-2015

* If no cached file in source/ go here:
local URL "http://mattpearce.name/files/fh2015.dta"
* Prefix this source's variables with:
local PREFIX "fh"
* What is the year variable called in the source:
local YEARVAR "year"
* What is the country variable called in the source:
local COUNTRYVAR "country"
* Which set of ids are used, matching "source" field in UCIMergeList:
local MERGEWITH "fh"
* Which field in UCIMergelist matches the country variable above (Name, Alpha or Numeric):
local MERGEUSING "Name"

* Create the merge file to use with this source
tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

* If the file source file doesn't already exist then download and create it.
use_or_import_source `PREFIX' `URL'

* Do any transformations/recodes/corrections here

gen sum = cl + pr
label variable sum "Combined Civil Liberties and Political Rights score."

* Prefix the variables
prefix `PREFIX'

* Combine the merge file IDs with the current source
merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master
