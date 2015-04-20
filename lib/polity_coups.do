* 2013 Polity CSP Coups
local URL "http://www.systemicpeace.org/inscr/CSPCoupsAnnual2013.xls"
local PREFIX "polity_coups"
local YEARVAR "year"
local COUNTRYVAR "ccode"
local MERGEWITH "Polity"
local MERGEUSING "Numeric"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

* If the file source file doesn't already exist then download and create it.
use_or_import_source_excel `PREFIX' `URL'

* Fixes:
* Drop Sudan Transition Overlap
drop if `COUNTRYVAR' == 626 & year == 2011
* Drop Ethiopian Transition Overlap
drop if `COUNTRYVAR' == 530 & year == 1993
* Drop Vietnam Transition Overlap
drop if `COUNTRYVAR' == 816 & year == 1976

prefix `PREFIX'

merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the dataset
merge_with_master
