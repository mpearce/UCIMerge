* 2015 The Lexical Index of Electoral Democracy (LIED)
* http://ps.au.dk/forskning/forskningsprojekter/dedere/datasets/
* LIED provides COW Numeric codes - however these codes combine historic and contemporary states in a way that may not be ideal. This is why this merge uses Name.

local URL "http://ps.au.dk/fileadmin/Statskundskab/Dokumenter/Forskning/Forskningscentre/DEDERE/lied.xls"
local PREFIX "lied"
local YEARVAR "year"
local COUNTRYVAR "country_name"
local MERGEWITH "LIED"
local MERGEUSING "Name"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

use_or_import_source_excel `PREFIX' `URL'

prefix `PREFIX'

merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Merge with the Dataset
merge_with_master
