library(devtools)

install_github("ropengov/bibliographica")
library(bibliographica)
library(stringr)
library(knitr)
library(dplyr)
library(stringdist)
import::from(sorvi, harmonize_names)

source("harmonize_publisher.R")
source("harmonize_for_comparison.R")
source("extract_personal_names.R")


# NB! Data not included, because it's use is restricted
source.data.file <- "data/kungliga.csv"

output.folder <- "Output/"

df.orig <- read_bibliographic_metadata(source.data.file)


df <- data.frame(list(row.index = 1:nrow(df.orig)))

publication_year <- polish_year_of_publication(df.orig$publication_time)

publisher <- harmonize_publisher(df.orig$publisher, publication_year, language="swedish")
res <- cbind.data.frame(publisher=publisher$mod, orig=publisher$orig, combined_count=publisher$total)
filename <- paste(output.folder, "Publisher.csv", sep = "")

# Now some field order customizing
publisher$parent_total <- NA
x <- data.frame(publisher)

inds <- which(publisher$total==0)
for (ind in inds) {
    publisher$parent_total[ind] <- as.numeric(as.vector(max(publisher$total[which(publisher$mod==publisher$mod[ind])])))
}
inds <- which(publisher$total!=0)
publisher$parent_total[inds] <- as.numeric(as.vector(publisher$total[inds]))

publisher <- publisher[order(-as.numeric(as.vector(publisher$parent_total)), publisher$mod, -publisher$total, publisher$orig),]
publisher$parent_total <- NULL
write.table(publisher, file = filename, quote = FALSE, sep = "\t", row.names = FALSE)




# List only the modified publisher names
inds <- which(as.character(publisher$orig) != as.character(publisher$mod))
if (length(inds>0)) {
  filename <- paste(output.folder, "Publisher_modified.csv", sep = "")
  res <- cbind.data.frame(original_publisher=publisher$orig[inds], modified_publisher=publisher$mod[inds])
  write.table(res, file = filename, quote = FALSE, sep = "\t", row.names = FALSE)
}
