#setting working directory 
setwd("T:\\Tableau_BankProject")

#link of the json file
url="http://srvmanager.tmsys.in:81/ServerManagerTmspl/dashboardtm/getDataApi"

#download json file
download.file(url,"datacenter.json",quiet = TRUE, mode = "w")

library(jsonlite)

#reading json file
mydf = fromJSON("datacenter.json",simplifyVector = TRUE)

# removeing unnecessary data and store to dataframe
mydf = mydf[["server_data"]]

#Replace N/A with blank
mydf[] <- lapply(mydf[], gsub, pattern = 'N/A', replacement='')

#extract hours,minutes and seconds
hours <- as.numeric(gsub('^(?:.* )?([0-9]+)h.*$','\\1',mydf[,5]))
minutes <- as.numeric(gsub('^.* ([0-9]+)m.*$','\\1',mydf[,5]))
seconds <- as.numeric(gsub('^.* ([0-9]+)s.*$','\\1',mydf[,5]))

#convert to seconds
mydf[,5] <- seconds + 60*minutes + 60*60*hours

#adding seconds in last update time
mydf[,9] <- mydf[,5]+as.POSIXct(mydf[,6])

names(mydf)[9]<-paste("estimated_time")

library(RMySQL)

mydb = dbConnect(MySQL(), user='tmspl', password='tmsystem@321', dbname='ServerDashboard', host='192.168.52.208')

#delete existed table
dbGetQuery(mydb, "DROP TABLE `server_info`;")

#Create database table
dbGetQuery(mydb, "CREATE TABLE `server_info` (
  `row_names` int(225) DEFAULT NULL,
           `id` int(225) DEFAULT NULL,
           `lable` varchar(225) DEFAULT NULL,
           `status` varchar(225) DEFAULT NULL,
           `remaining_bytes` int(225) DEFAULT NULL,
           `remaining_time` datetime DEFAULT NULL,
           `last_update_date_time` datetime DEFAULT NULL,
           `replication_status` varchar(225) DEFAULT NULL,
           `prev_last_updated_time` datetime DEFAULT NULL,
           `estimated_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
           ")

#saving dataframe to mysql
dbWriteTable(mydb, name='server_info', value=mydf,append=TRUE)

#closeing database connection
dbDisconnect(mydb)
