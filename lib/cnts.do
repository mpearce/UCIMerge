* Cross National Time Series http://www.databanksinternational.com
* expects to find private/cnts.xls

local PREFIX "cnts"
local URL "private/`PREFIX'.xls"
local YEARVAR "year"
local COUNTRYVAR "country"
local MERGEWITH "CNTS"
local MERGEUSING "Name"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

use_or_import_source_excel `PREFIX' `URL'

destring code, replace

* Fix a typo
replace country = "PERU" if code == 930 & year == 2010

prefix `PREFIX'

* Merge UCIID
merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master
