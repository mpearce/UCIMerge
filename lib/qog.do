* 2016 Quality of Government Standard dataset 2016 - Time-Series
* http://qog.pol.gu.se/data/datadownloads/qogstandarddata
* Teorell, Jan, Stefan Dahlberg, Sören Holmberg, Bo Rothstein, Anna Khomenko & Richard Svensson. 2016. The Quality of Government Standard Dataset, version Jan16. University of Gothenburg: The Quality of Government Institute, http://www.qog.pol.gu.se doi:10.18157/QoGStdJan16

local URL "http://www.qogdata.pol.gu.se/data/qog_std_ts_jan16.dta"
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

prefix `PREFIX'
merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master `FILENAME'
