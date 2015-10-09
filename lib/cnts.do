* Cross National Time Series 2015 http://www.databanksinternational.com
* expects to find private/cnts.xls with the first row as the header

local PREFIX "cnts"
local URL "private/`PREFIX'.xls"
local YEARVAR "year"
local COUNTRYVAR "code"
local MERGEWITH "CNTS"
local MERGEUSING "Numeric"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

use_or_import_source_excel `PREFIX' `URL'

destring code, replace

prefix `PREFIX'

* Merge UCIID
merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master
