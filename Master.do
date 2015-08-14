version 13
* Written and tested using STATA 13.
* Run 'do master' in Stata to compile a new copy of the UCIMerge dataset to the working directory
include lib/begin

* Uncomment/Comment to inclue/exclude in dataset
* include lib/source
include lib/fh
*include lib/polity
*include lib/polity_coups
*include lib/norris
*include lib/wdi
*include lib/kof
*include lib/lied
*include lib/ciri
*include lib/qog

* These sets may require manual downlaod. URLS are provided in the DO files.
* include lib/cnts
* include lib/pwt

* Use /private to store unreleased datasets or custom transformations
* include private/univ
* include private/uia
include private/mycustomstuff

* Complete the merge:
include lib/end
