extract_personal_names  <- function(x) {
    full_name = str_extract(x, "((([[:upper:]][[:lower:]]+) |([[:upper:]][.] ?)))+[[:upper:]][[:lower:]]+")
    number_of_given_names = (str_count(full_name, "[[:upper:]]") - 1)
    given_names_pattern <- paste("((([[:upper:]][[:lower:]]+) |([[:upper:]][.] ?))){", (number_of_given_names), "}", sep = "")
    given_names = str_extract(full_name, given_names_pattern)
    initials = gsub("[[:lower:]]+ ", ".", given_names)
    family_name = str_replace(full_name, given_names, "")
    guessed <- (given_names != initials)
    
    initials = gsub(" ", "", initials)
    family_name = gsub(" ", "", family_name)
    
    init_name = as.character(paste(initials, family_name, sep=" "))
    full_name_with_initials <- str_replace(x, full_name, init_name)
    
    for (i in nrow(x)) {
      if (is.na(initials[i])) {guessed[i] <- NA}
    }
    return (data.frame(initials=initials, family=family_name, full_name=full_name, init_name=full_name_with_initials, guessed=guessed))
    
  
}
