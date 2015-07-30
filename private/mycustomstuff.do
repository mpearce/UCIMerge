/*
Use this file to create custom functions and merges.
*/

* include private/un
* include private/oecd

* An exmaple to replace a prefix
* rename norris_* n_*

/* Creates value labels from string variables and replaces current variable.
If you use this consistently for a dataset, consider submitting an updated .do file for that source. */
* encode_value_labels fh_status

* UCINumeric is renamed to country after aligning with a value list created from UCIName
* drop UCIName

* A stupidly expensive operation to alphabetize the variables:
* order _all, alpha
