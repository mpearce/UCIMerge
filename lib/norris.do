* 2009 Norris Dataset
local URL "http://www.hks.harvard.edu/fs/pnorris/Data/Democracy%20TimeSeries%20Data/Democracy_TimeSeries_Data_January2009_StataSE.dta"
local PREFIX "norris"
local YEARVAR "Year"
local COUNTRYVAR "Refno"
local MERGEWITH "Norris"
local MERGEUSING "Numeric"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

* If the file source file doesn't already exist then download and create it.
use_or_import_source `PREFIX' `URL'

/*
Norris 2009 Notes:
This merge uses Refno accounting for the inconsistencies below. Refno may be not work if there is an update to the dataset.

* duplication with Congo Braz CCODE 484 (2005,2006) and Angola CCODE 540 (1980)
* Refno 7, Year: 1971 - Likely Argentina
* Refno 65, Year: 1971 - Likely Ghana
* Refno 87, Year: 1971 - Likely Kenya
* Refno 46,84,85 have missing Natcode, but not inconsistent
*/

prefix `PREFIX'
merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

duplicates drop UCINumeric year, force

* Merge with the Dataset
merge_with_master `FILENAME'
