#' @importFrom sorvi harmonize_names
harmonize_for_comparison <- function(x, language="english") {
  
  if (language=="swedish") {
    f <- "sv_publisher_comparison.csv"
  } else if (language=="english") {
    
  } else {
    
  }

  synonyms <- read.csv(f, sep = "\t", fileEncoding = "UTF-8")
  
  x <- harmonize_names(x, synonyms, mode="recursive")$name
  x

}
