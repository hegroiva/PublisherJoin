#Data

##Lament
The usage of the data is restricted, so I can't upload it here.


##Description
The metadata from the National Library of Sweden (Kungliga biblioteket).<br>
Contains data fields separated by vertical bars.<br>
Each data row equals one publication.


##Fields of importance for PublisherJoin
###Publication year
Contains the publication year.<br>
Usually just one year, but could also be a range.
###Publisher
Usually the publisher name, but could also contain the commissioner or distributor or a combination of these.
+ No way to distinguish between the different roles.

Contains lots of noise and orthographical differences.




#Program

##Usage
Run main.R by any means necessary<br>
harmonize_publisher is called from main.R

##More details about harmonize_publisher()
###Parameters
  + x
    * vector containing the publisher field as it exists in kungliga.csv
  + publication_year
    * data frame with three vectors
      - published_in<br>
		  the year, when the publication year by one year only in the data
      - published_from<br>
			start year, when the publication year has been stated by a range of years
      - published_till<br>
			end year, when the publication year has been stated by a range of years
  + language
    * string, with fixed values
      - swedish is currently the only supported language

###Processing order
1. Select publisher name from the list
  + In case of parentheses or brackets preceding text without parenteses or brackets, only the sequential text will be selected
  + Several publishers (or other actors) might be separated by semi-colons
    * Select the first name before the semi-colon
  + The rules for the selection might change later
  
2. Remove scrap from the end
  + There are lots of variants used to separate multiple publishers, such as ":;", ".;"

3. Write out any abbreviations
  + The abbreviations are language-specific

4. Remove extra brackets or parentheses

5. Add space around ampersands
 
6. Harmonize initials
  + Initials will be followed by a dot only
  + There's a single space between the last initial and the family name

7. Get the first and last publication year for each publisher name

8. Get the publisher name forms into a table
  + Sort the table from the most common to the least common

9. Prepare the stop mechanism
  + The stop mechanism is needed to prevent common family names getting mixed up with each other fuzzily
  + The principle in the background is, that a native-language librarian is less likely to make mistakes in common roots, than in the prefixes
    * eg. Rundqvist vs. Lundqvist -error is, Johansson vs. Johanson plausible

10. Unify orthography and write out the unambiguous first names
  + The orthography changes and the name abbreviations are language-specific
  + The name abbreviations are resolved from the data
    * eg. Th. -> Thorvald, Aug. -> August

11. Resolve initials of the publisher names
  + The initials are resolved for every publisher name, even if it's a company name
    * There's no need (nor a way) to separate company names from person names

12. Combine publisher name forms, that have the same referent
  + If two name forms are combined, the more common will be considered the correct one
  + There'll be no combining into a name form with 1 or 2 occurrences
    * Matching would take too much time
    * Selecting the wrong name form would happen too easily
  + The publication years must coincide for personal names, but not for company names
    * The publisher name might be a personal name, even when it's actually a company<br>
      -> Treat publisher names as company names, unless
        1. it actually contains initials
        2. matches with a previous name, that contains initials
    * The publishing years must overlap
    * Maximum five year difference is allowed between the last of publication of one publisher and the first of an another
  + If a name is matched to a name, that itself has been matched to another, the highest in the chain is considered the correct one
  + Personal names: full name vs. initials
    * Use fuzzy matching, if the family names match exactly
  + Personal names: initials vs. initials
    * Use fuzzy matching, if the initials match exactly
  + Personal names: full name vs. full name
    * Use fuzzy matching
    * NB! Treated as a company name
	
	
