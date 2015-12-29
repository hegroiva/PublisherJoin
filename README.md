# PublisherJoin
##Purpose
  + Join publisher names written in multiple ways
    * Try to minimize redundant publisher names from metadata
  + Publisher names have been written in numerous ways
    * The standards of writing the metadata has changed through times
    * Spelling mistakes
    * Orthographical changes
    * Publishers themselves have had their names written in different ways

## Files needed for handling
  * main.R
    * Imports the necessary libraries
    * writes the output .csv
    
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
    
##How to read the output file Publisher.csv
  * order from the most frequent publisher name group to the least frequent
    + the order within the publisher name group is alphabetical, except for the most frequent name group, which is first
  * four columns
     + orig
       - the original value before (almost) any changes
       - if the field contained multiple publishers, the first one (un-bracketed and un-parenthesized) is used
     + mod
       - the value, into which it was combined
     + comp
       - the value after modifications, before combining into anything
       - empty, if only one or two occurrences in the original data
     + total
       - total count of occurrences combined, by any name form
       - zero, if the publisher name was combined into something else
     
##How to read the output file Publishers_combined.csv
    * lists only the changes values and their originals
    * order from the most frequent publisher name group to the least frequent
      + the order within the publisher name group is alphabetical
    * two columns
      + original_publisher
        - the original value before (almost) any changes
        - if the field contained multiple publishers, the first one (un-bracketed and un-parenthesized) is used
      + modified_publisher
        - the value, into which the original value was changed
