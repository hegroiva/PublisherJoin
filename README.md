# PublisherJoin
Join publisher names written in multiple ways

# Files needed for handling
  * harmonize_publisher.R
    * Contains the main code

  * harmonize_for_comparison.R
    * Contains the code for handling the historical changes of the language, ie. unifies spelling variations. 
      * eg. öfver -> över
    * Common unambiguous abbreviations of first names are spelled out.
      * eg. Aug. -> August

  * extract_personal_names.R
    * Contains the code to get a _possible_ 
      * initial
      * family name
      * full name
      * full name initialized
      * information, whether the initials were deduced from publisher name

  * sv_publisher.csv
    * csv file for spelling out abbreviations
    * language specific
    * two columns
      * synonyme: gsub pattern, which will be changed to a new value
      * name: the new value _(Might be empty, in which case the pattern will be removed)_

  * sv_publisher_comparison.csv
    * csv file for describing synonymous spelling variations and unambiguous first name abbreviations
    * language specific
    * two columns
      * synonyme: gsub pattern, which will be changed to a new value
      * name: the new value
  
  * sv_publisher_caveat.csv
    * csv file containing name parts of common family names, that aren't typically misspelled, but are really close to another
      * eg. Lind <-> Lund; Rund <-> Lund
    * the name parts are used to prevent unifying two family names with each other, if they contain names of first and second column respectively
      * eg. Thomas Lindstedt will not be unified with T. Lundstedt
    * two columns
      * name1: name part of common family name, closely resembling name2
      * name2: name part of another common family name, closely resembling name1
    * one occurrence of each pair is enough, the program takes care of the reverse prevention
    * language specific
    
