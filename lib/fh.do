* 2016 Freedomhouse Freedom in the World Report
* https://freedomhouse.org/report-types/freedom-world

* If no cached file in source/ go here:
local URL "https://raw.githubusercontent.com/mpearce/FH/master/FH2016.csv"
* Prefix this source's variables with:
local PREFIX "fh"
* What is the year variable called in the source:
local YEARVAR "year"
* What is the country variable called in the source:
local COUNTRYVAR "UCINumeric"
* Which set of ids are used, matching "source" field in UCIMergeList:
local MERGEWITH "UCI"
* In this example, the source already has a UCINumeric column.
* The "UCI" source is a replication of the UCICountries codes.

* Which field in UCIMergelist matches the country variable above (Name, Alpha or Numeric):
local MERGEUSING "Numeric"

* Create the merge file to use with this source
tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

* If the file source file doesn't already exist then download and create it.
use_or_import_source_csv `PREFIX' `URL'

* Do any transformations/recodes/corrections here
gen sum = cl + pr
label variable sum "Combined Civil Liberties and Political Rights score."

* Prefix the variables
prefix `PREFIX'

encode_value_labels fh_status

* Combine the merge file IDs with the current source
merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

drop `PREFIX'_UCINumeric

* Merge with the Dataset
merge_with_master
