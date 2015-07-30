* 2014 CIRI Human Rights Dataset
* Cingranelli, David L., David L. Richards, and K. Chad Clay. 2014. "The CIRI Human Rights Dataset."  http://www.humanrightsdata.com. Version 2014.04.14.

local URL "https://drive.google.com/uc?export=download&id=0BxDpF6GQ-6fbTUJZOExlM0FQVFk"
local PREFIX "ciri"
local YEARVAR "YEAR"
local COUNTRYVAR "CIRI"
local MERGEWITH "CIRI"
local MERGEUSING "Numeric"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

use_or_import_source_excel `PREFIX' `URL'

* Remove cases where there is no data to prevent overlapping country codes
egen check = rownonmiss(PHYSINT DISAP KILL POLPRIS TORT OLD_EMPINX NEW_EMPINX ASSN FORMOV DOMMOV OLD_MOVE SPEECH ELECSD OLD_RELFRE NEW_RELFRE WORKER WECON WOPOL WOSOC INJUD)
drop if check == 0
drop check

prefix `PREFIX'

merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master
