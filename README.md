[![DOI](https://zenodo.org/badge/3897/mpearce/UCIMerge.svg)](https://zenodo.org/badge/latestdoi/3897/mpearce/UCIMerge)

# UCIMerge - a framework for harmonizing cross national time series data

## Read Me
UCIMerge is a framework in STATA to standardize the merging of international comparative datasets. This project creates conventions and a library of functions so that it becomes easier and faster to merge time series datasets, incorporate updates, make sure observations are consistent across years, conserve N and encourage reproducible research.

This framework came about from conversations at the [UC Irvine International Comparative Workshop](http://sites.uci.edu/icsw/).

Download the [latest release](https://github.com/mpearce/UCIMerge/releases/latest). Join the [announcement list](http://eepurl.com/btU40r) to receive notifications of updates.

## How to use UCIMerge

The first time you run the scripts, it will take an extremely long time to update the datasets from the web. If you would like to jumpstart this, you can use this [starter pack](http://mattpearce.name/files/UCIMergeStarterPack.zip) by drop these files into the /source directory. If you want to force the system to refresh a dataset, just delete that dataset file from /source.

1. Set the UCIMerge folder as the working directory for STATA ('cd ~/UCIMerge')

2. Edit the Master.do file with the configuration that you would like.

3. Run 'do master' -> your new dataset will be opened and saved within the UCIMerge folder.

UCIMerge requires STATA 13. The .csv files which link countries across datasets can be used independently.

## Currently Supported Datasets

* [Norris 2009](https://sites.google.com/site/pippanorris3/research/data#TOC-Democracy-Time-series-Data-Release-3.0-January-2009)
* [Freedom House 2016](https://freedomhouse.org/report/freedom-world/freedom-world-2015)
* [Polity IV](http://www.systemicpeace.org/polityproject.html)
* Polity IV Coups
* [World Development Indicators](http://data.worldbank.org)
* [KOF Index of Globalization](http://globalization.kof.ethz.ch)
* [The Lexical Index of Electoral Democracy (LIED)](http://ps.au.dk/forskning/forskningsprojekter/dedere/datasets/)
* [CIRI Human Rights Dataset](http://www.humanrightsdata.com)
* [Quality of Government Standard dataset](http://qog.pol.gu.se/data/datadownloads/qogstandarddata)
* [Cross National Time Series](http://www.cntsdata.com)
* [Penn World Table version 8.1](http://www.rug.nl/research/ggdc/data/pwt/pwt-8.1)

You can add your own datasets by using one of these examples as a template.

## Structure and Philosophy

Intuitive directory structures and naming conventions means writing less code!

### Files
* **Master.do** - Configure your merge by commenting/uncommenting the datasets that you want included.
* **UCIMergeList.csv** - An index of dataset country codes and their corresponding standardized UCIMerge code.
* **UCICountries.csv** - An index of UCIMerge codes for countries.
* **/private/MyMergeList.csv** - if the file is present, it is automatically included into the UCIMergeList. Use this to add your own country codes.

### Directories
* **/lib** - Location for the project .do files. One .do file for each dataset.
* **/source** - Location for cached version of the original dataset. UCIMerge will look here for a .dta file with the same prefix as the merge. If if doesn't find a copy, and the dataset merge file specifies a location on the internet, then UCIMerge will try to download a copy.
* **/private** - Location for your customized functions, datasets and MergeLists for datasets that are not part of the core UCIMerge project.

## About Contributions
Please contribute! If you discover an error, please submit an issue on github or send a fix.

To contribute a new dataset:
* create a new merge .do file in the /lib directory. The polity.do is a well documented template.
* include the file in Master.do file
* update the UCIMergeList.csv with the new country code entries. Sort the merge list by the Source and UCINumeric fields.

Submit a pull request through github, or email your changes to [pearcem@uci.edu](mailto:pearcem@uci.edu). We'd love to have your contributions!

If you use this framework, consider citing so that others can find it and contribute.

Pearce, Matthew. 2016. "UCIMerge - a framework for harmonizing cross national time series data." (https://github.com/mpearce/UCIMerge) doi:10.5281/zenodo.27933
