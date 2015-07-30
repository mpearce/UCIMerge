drop if year == .
notes drop _dta

rename UCINumeric country
label variable country "Country"
label variable year "Year"
order country year UCI*

compress
save "$FILENAME", replace
