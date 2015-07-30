* 2015 KOF Index of Globalization
* http://globalization.kof.ethz.ch

local URL "http://globalization.kof.ethz.ch/media/filer_public/2015/03/04/globalization_2015_long.xls"
local PREFIX "kof"
local YEARVAR "year"
local COUNTRYVAR "code"
local MERGEWITH "KOF"
local MERGEUSING "Alpha"
local SHEET `" "data long" "'

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

use_or_import_source_excel `PREFIX' `URL' `SHEET'

* Clean additional header on first row
rename (A B C) (country code year)
drop in 1

destring year economicglobalization actualflows restrictions socialglobalization personalcontact informationflows culturalproximity politicalglobalization overallglobalizationindex, replace

prefix `PREFIX'

merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master
