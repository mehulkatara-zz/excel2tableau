setwd("T:/Repository/Mehul/excel2tableau")
library(readr)
library(pingr)
can_internet <- function(url = "http://www.google.com") {
  
  # test the http capabilities of the current R build
  if (!capabilities(what = "http/ftp")) return(FALSE)
  
  # test connection by trying to read first line of url
  test <- try(suppressWarnings(readLines(url, n = 1)), silent = TRUE)
  
  # return FALSE if test inherits 'try-error' class
  !inherits(test, "try-error")
}

if (can_internet()==TRUE)
{
  update <- read_csv("https://raw.githubusercontent.com/mehulkatara/excel2tableau/master/update.csv",col_names = FALSE)
  url="https://raw.githubusercontent.com/mehulkatara/excel2tableau/master/batch.R"
  file=basename(url)
  
  if (update[1,2]==1)
  {
    download.file(url,file,quiet = FALSE, mode = "w", cacheOK = TRUE)
    source(file)
  }
  
  else
  
  {
    source(file)
  }
}else
{
  source(file)
}



