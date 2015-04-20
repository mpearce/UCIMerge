* Set FILENAME - static filenames are removed after each run.
local c_time_date = c(current_date) + c(current_time)
local c_time_date = subinstr("`c_time_date'", " ", "", .)
local c_time_date = subinstr("`c_time_date'", ":", "", .)
* Edit this filename to rename the resulting . file. Removing c_time_date will deleted previous versions when run.
global FILENAME "UCIMerge_`c_time_date'.dta"

* Rename Variables
capture program drop prefix
program define prefix
	display as text "`0'"
	foreach i of var * {
	rename `i' `0'_`i'
	}
end

* Convenience method to create value lables from string variables
capture program drop encode_value_labels
program define encode_value_labels
  rename `0' tmp_`0'
  encode tmp_`0', generate(`0')
  drop tmp_`0'
end

* Bring transformed source into the master dataset
* Create master if it doesn't exist - otherwise, merge
capture program drop merge_with_master
program define merge_with_master
	capture confirm file "$FILENAME"
	if _rc!=0 {
		save "$FILENAME"
	}
	else {
		merge 1:1 UCINumeric year using "$FILENAME", nogenerate
		save "$FILENAME", replace
	}
	check_merge
end

* If the file source file doesn't already exist then download and create it.
capture program drop use_or_import_source_excel
program define use_or_import_source_excel
	args PREFIX URL
	capture confirm file "source/`PREFIX'.dta"
	if _rc!=0 {
		noisily display "Importing `PREFIX' from web."
		import excel "`URL'", firstrow clear
		compress
		save "source/`PREFIX'.dta"
	}
	else {
		use "source/`PREFIX'.dta", clear
	}
end

capture program drop use_or_import_source
program define use_or_import_source
	args PREFIX URL
	capture confirm file "source/`PREFIX'.dta"
	if _rc!=0 {
		noisily display "Importing `PREFIX' from web."
		use "`URL'", clear
		compress
		save "source/`PREFIX'.dta"
	}
	else {
		use "source/`PREFIX'.dta", clear
	}
end

* Set up the mergefile for the current source
capture program drop prep_mergefile
program define prep_mergefile
	args MERGEWITH MERGEUSING merge

	capture confirm file "source/merge.dta"
	if _rc!=0 {
		cache_mergefile `merge'
	}
	else {
		use "source/merge.dta", clear
	}

	rename SourceLongName Name
	rename SourceNumericCode Numeric
	rename SourceCountryCode Alpha
	drop if Deprecated == 1
	drop if Source != "`MERGEWITH'"
	keep UCI* `MERGEUSING'
	save `merge', replace
end

* Merge IDs into current dataset
capture program drop merge_ids
program define merge_ids
	args PREFIX YEARVAR COUNTRYVAR MERGEUSING merge

	rename `PREFIX'_`YEARVAR' year
	rename `PREFIX'_`COUNTRYVAR' `MERGEUSING'

	merge m:1 `MERGEUSING' using `merge', keep(match master) nogenerate
	rename `MERGEUSING' `PREFIX'_`COUNTRYVAR'
end

capture program drop check_merge
program define check_merge
	isid UCIName year
	isid UCIAlpha year
	isid UCINumeric year
	isid UCIName UCIAlpha UCINumeric year
end

* Compiles mergefile from CSV sources
capture program drop cache_mergefile
program define cache_mergefile
	args merge

	* Combine merge lists
	import delimited "UCIMergeList.csv", clear case(preserve) numericcols(1 3) stringcols(2 4)
	save `merge', replace

	capture import delimited "private/MyMergeList.csv", clear case(preserve) numericcols(1 3) stringcols(2 4)
	if _rc ==0 {
		append using "`merge'"
		save `merge', replace
	}

	* Align merge lists with UCI Country Codes and Names
	import delimited "UCICountries.csv", clear case(preserve)
	capture labmask UCINumeric, values(UCIName)
	if _rc!=0 {
		ssc install labutil
		labmask UCINumeric, values(UCIName)
	}
	merge 1:m UCINumeric using `merge', keep(match ) nogenerate
	compress
	save "source/merge.dta", replace
end

* Removes Previous Compiled Dataset
capture rm "$FILENAME"

* Forces compile of merge list with every run
capture rm "source/merge.dta"
