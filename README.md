# Read Me
UCIMerge is a framework in STATA to standardize the merging of international comparative datasets. This project creates conventions and a library of functions so that it becomes easier and faster to merge time series datasets, incorporate updates, make sure observations are consistent across years, and conserve N.

This framework came about from conversations at the [UC Irvine International Comparative Workshop](http://sites.uci.edu/icsw/).

## How to use UCIMerge

The first time you run the scripts, it will take an extremely long to update the datasets from the web. If you would like to jumpstart this - use this [starter pack](http://mattpearce.name/files/UCIMergeStarterPack.zip); drop these files into the /source directory. If you want to force the system to refresh a dataset, just delete that dataset from /source.

1. Set the UCIMerge folder as the working directory for STATA ('cd ~/UCIMerge')

2. Edit the Master.do file with the configuration that you would like.

3. Run 'do master' -> your new dataset will be opened and saved within the UCIMerge folder.

UCIMerge requires STATA 13.

## Currently Included Datasets

* [Norris 2009](https://sites.google.com/site/pippanorris3/research/data#TOC-Democracy-Time-series-Data-Release-3.0-January-2009)
* [Freedom House 2015](https://freedomhouse.org/report/freedom-world/freedom-world-2015)
* [Polity IV](http://www.systemicpeace.org/polityproject.html)
* Polity IV Coups
* [World Development Indicators](http://data.worldbank.org)

## Structure and Philosophy

Intuitive directory structures and naming conventions means writing less code!

### Files
* **Master.do** - Configure your merge by commenting/uncommenting the datasets that you want included.
* **UCIMergeList.csv** - An index of dataset country codes and their coresponding standardized UCIMerge code.
* **UCICountries.csv** - An index of UCIMerge codes for countries.
* **/private/MyMergeList.csv** - if the file is present, it is automatically included into the UCIMergeList

### Directories
* **/lib** - Location for the project .do files. One .do file for each dataset
* **/source** - Location for cached version of the original dataset. UCIMerge will look here for a .dta file with the same prefix as the merge. If if doesn't find a copy, and the dataset merge file specifies a location on the internet, then UCIMerge will try to downlaod a copy.
* **/private** - Location for your customized functions, datasets and MergeLists for datasets that are not part of the core UCIMerge project.


## About Contributions
Please contribute! If you discover an error, please submit an issue or send a fix.

To contribute a new dataset:
* create a new merge .do file in the /lib directory.
* include the file in Master.do file
* update the UCIMergeList.csv with the new country code entries. Sort the merge list by the UCINumeric and Source fields.

Submit a pull request through github, or email your changes to [pearcem@uci.edu](mailto:pearcem@uci.edu). We'd love to have your contributions!
