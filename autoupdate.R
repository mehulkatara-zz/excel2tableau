setwd("T:/Repository/Mehul/excel2tableau")
library(readr)
update <- read_csv("https://raw.githubusercontent.com/mehulkatara/excel2tableau/master/update.csv",col_names = FALSE)
url="https://raw.githubusercontent.com/mehulkatara/excel2tableau/master/batch.R"
file=basename(url)

if (update[1,2]==1)
{
download.file(url,file,quiet = FALSE, mode = "w", cacheOK = TRUE)
source(file)
}

{source(file)}
