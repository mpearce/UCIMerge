# About UCINumeric and UCIAlpha

So why would we create another country coding scheme when there are so many great ones out there already?
We know... we know... so many.

UCINumeric and UCIAlpha are loosely based on the Correlates of War codes with a little extra.

We were finding that we were inconsistently patching other id schemas to address problems:
* Political bodies move to slow to incorporate new countries (ISO, UN, etc)
* Some schemas would exclude disputed territories
* Dead countries are also interesting, but often skipped in coding
* Other codes were not designed specifically for merging, expansion, and wide contribution
* Country names change, but the country itself might not
* Some sets do not go back as far back in history as we wanted
* Handling aggregates - you have the option to match, or drop them (default is to drop)
* We needed something more standardized to use when passing datasets between collaborators

Each alpha and numeric code is unique within UCICountries. Within your own dataset, there may be overlaps and inconsistencies the require merging decisions. The "deprecation" column is there if you would like a one country code to supersede an another (possibly older) code within a specific merge.

## Numbers
Where possible we are using to these conventions.

Reserved:
* 1 - 3899: Countries / entities
* 3900 - 3999: Slack / catch all codes found in some datasets
* 4000 - 4999: Reserved for datasets tracking exiled populations
* 5000 - 6999: Aggregate measurements (EU, OECD, etc)

Unreserved:
9000 - 9999: Free for all - experiment here! If you find you are regularly using a code, submit it for inclusion.

## Contributions
We can move faster than your average dataset. If you find that you are creating a code that is not already represented, review these guidelines and submit an update.
