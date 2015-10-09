drop if year == .
notes drop _dta

rename UCINumeric country
gen UCINumeric = country
label variable country "Country"
label variable year "Year"
order country year UCI*
sort country year

compress
save "$FILENAME", replace
