* 2015 Polity 4
* http://www.systemicpeace.org/polity/polity4.htm

* If no cached file in source/ go here:
local URL "http://www.systemicpeace.org/inscr/p4v2015.xls"
* Prefix this source's variables with:
local PREFIX "polity"
* What is the year variable called in the source:
local YEARVAR "year"
* What is the country variable called in the source:
local COUNTRYVAR "ccode"
* Which set of ids are used, matching "source" field in UCIMergeList:
local MERGEWITH "Polity"
* Which field in UCIMergelist matches the country variable above (Name, Alpha or Numeric):
local MERGEUSING "Numeric"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

* If the file source file doesn't already exist then download and create it.
use_or_import_source_excel `PREFIX' `URL'

* Fixes:
drop if year == .
* Drop Sudan Transition
drop if cyear == 6252011
* Drop Ethiopian Transition
drop if cyear == 5301993
* Drop Vietnam Transition
drop if cyear == 8161976

prefix `PREFIX'

merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the dataset
merge_with_master
