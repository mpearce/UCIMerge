* 2016 World Develoment Indicators
* http://data.worldbank.org/

local PREFIX "wdi"
local YEARVAR "year"
local COUNTRYVAR "countrycode"
local MERGEWITH "WDI"
local MERGEUSING "Alpha"

tempfile merge
prep_mergefile `MERGEWITH' `MERGEUSING' `merge'

* If the file source file doesn't already exist then download and create it.
capture use "source/`PREFIX'.dta", clear
if _rc!=0 {
  noisily display "Importing `PREFIX' from web."
  * set timeout1 360
  * set timeout2 1540
  * Make sure you are using the latest wbopendata update, it will save you headache.
  ssc install wbopendata
  tempfile wdi
  save `wdi', replace
  * Topic 18 doesn't seem to be returning
  foreach x of numlist 1/17 19/21 {
    capture use "source/`PREFIX'`x'.dta"
    if _rc!=0 {
      wbopendata, language(en - English) topics(`x') clear long
      save "source/`PREFIX'`x'.dta"
    }
    if `x' != 1 {
      merge 1:1 countryname year using `wdi', nogenerate
      }
    save `wdi', replace
  }
  compress
  save "source/`PREFIX'.dta"

  * Cleanup redundant cache files
  foreach x of numlist 1/17 19/21 {
    capture rm "source/`PREFIX'`x'.dta"
  }

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
