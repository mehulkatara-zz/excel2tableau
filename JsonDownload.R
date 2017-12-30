setwd("T:\\Tableau_BankProject")

url="http://srvmanager.tmsys.in:81/ServerManagerTmspl/dashboardtm/getDataApi"

download.file(url,"datacenter.json",quiet = TRUE, mode = "w")

library(jsonlite)

mydf = fromJSON("datacenter.json",simplifyVector = TRUE)

mydf = mydf[["server_data"]]

#Replace N/A with blank
mydf[] <- lapply(mydf[], gsub, pattern = 'N/A', replacement='')

#Replace space with :
mydf[5]=lapply(mydf[5],gsub, pattern=' ', replacement = ':')

#Replace alpha with blank
mydf[5]=lapply(mydf[5],gsub, pattern='[[:alpha:]]', replacement = '')

date=format(Sys.time(), "%Y-%m-%d")

mydf[5]=lapply(mydf[5],function(x) paste(date, x,sep=" "))

write.csv(mydf,file="T:\\Tableau_BankProject\\mehul.csv")