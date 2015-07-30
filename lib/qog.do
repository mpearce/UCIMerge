* 2015 Quality of Government Standard dataset 2015 - Time-Series
* http://qog.pol.gu.se/data/datadownloads/qogstandarddata

local URL "http://www.qogdata.pol.gu.se/data/qog_std_ts_jan15.dta"
local PREFIX "qog"
local YEARVAR "year"
local COUNTRYVAR "ccode"
local MERGEWITH "QOG"
local MERGEUSING "Numeric"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

* If the file source file doesn't already exist then download and create it.
use_or_import_source `PREFIX' `URL'

* Drop observations with empty variables to avoid merge conflicts
ds ccode cname year ccodealp cname_year ccodealp_year ccodecow ccodewb version, not
egen _tmp = rownonmiss(`r(varlist)'), s
drop if _tmp == 0
drop _tmp

* Trim longer names to survive prefixing
rename *_demo_* *_d_*
rename *_mlexpecedu_* *_mled_*
rename *_taxrate_* *tax*
rename *hlth* *hl*

prefix `PREFIX'
merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master `FILENAME'
