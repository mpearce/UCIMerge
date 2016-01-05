* 2015 World Develoment Indicators
* http://data.worldbank.org/

local PREFIX "wdi"
local YEARVAR "year"
local COUNTRYVAR "countrycode"
local MERGEWITH "WDI"
local MERGEUSING "Alpha"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

* If the file source file doesn't already exist then download and create it.
capture confirm file "source/`PREFIX'.dta"
if _rc!=0 {
  noisily display "Importing `PREFIX' from web."
  set timeout1 360
  set timeout2 1540
  capture wbopendata, language(en - English) topics(1) clear long
  if _rc!=0 {
    ssc install wbopendata
    wbopendata, language(en - English) topics(1) clear long
  }
  tempfile wdi
  save `wdi', replace
  foreach x of numlist 2/21 {
    wbopendata, language(en - English) topics(`x') clear long
    compress
    merge 1:1 countryname year using `wdi', nogenerate
    save `wdi', replace
  }
  save "source/`PREFIX'.dta"
}
else {
  use "source/`PREFIX'.dta", clear
}

* Fixes:
* Recent WDI changes have dropped the coutnrycode for Kosovo
replace countrycode = "KSV" if countryname == "Kosovo" & countrycode == ""

prefix `PREFIX'

merge_ids `PREFIX' `YEARVAR' `COUNTRYVAR' `MERGEUSING' `merge'

* Drop aggregates
drop if UCINumeric >= 5000

* Merge with the dataset
merge_with_master
