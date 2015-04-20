* 2014 Freedomhouse
local URL "https://acrowinghen.files.wordpress.com/2014/03/fredom-house-1972_2014.xlsx"
local PREFIX "fh"
local YEARVAR "year"
local COUNTRYVAR "ccode"
local MERGEWITH "COW"
local MERGEUSING "Numeric"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

* If the file source file doesn't already exist then download and create it.
use_or_import_source_excel `PREFIX' `URL'

prefix `PREFIX'

* Transformations
encode_value_labels `PREFIX'_status
drop if `PREFIX'_status == .

merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master
