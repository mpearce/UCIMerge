* 2015 Freedomhouse
local URL "http://mattpearce.name/files/fh2015.dta"
local PREFIX "fh"
local YEARVAR "year"
local COUNTRYVAR "country"
local MERGEWITH "fh"
local MERGEUSING "Name"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

* If the file source file doesn't already exist then download and create it.
use_or_import_source `PREFIX' `URL'

prefix `PREFIX'

* Transformations

merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master
