* Penn World Table version 8.1
* http://www.rug.nl/research/ggdc/data/pwt/pwt-8.1

local URL "http://www.rug.nl/research/ggdc/data/pwt/v81/pwt81.zip"
local PREFIX "pwt"
local YEARVAR "year"
local COUNTRYVAR "countrycode"
local MERGEWITH "ISO"
local MERGEUSING "Alpha"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

use_or_import_zipped_source `PREFIX' `URL'

prefix `PREFIX'

* Transformations
merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master
